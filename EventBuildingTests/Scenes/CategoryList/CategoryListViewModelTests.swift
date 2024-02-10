import Quick
import Nimble
import Combine

@testable import EventBuilding

final class CategoryListViewModelTests: QuickSpec {

    class override func spec() {

        var sut: CategoryListViewModel!

        var networkMock: NetworkProviderMock!
        var adapterSpy: CategoryListAdapterSpy!
        var formatterSpy: FormatterSpy!

        var onCategorySelectedParameters: [(
            category: EventBuilding.Category,
            selectedItemIds: Set<Int>,
            onItemsSelected: (([Item]) -> Void)?
        )]!
        var onCheckoutTappedParameters: [String]!

        var subcriptions = Set<AnyCancellable>()

        beforeEach {
            networkMock = NetworkProviderMock()
            adapterSpy = CategoryListAdapterSpy()
            formatterSpy = FormatterSpy()
            onCategorySelectedParameters = []
            onCheckoutTappedParameters = []

            sut = CategoryListViewModel(network: networkMock,
                                        adapter: adapterSpy,
                                        formatter: formatterSpy,
                                        onCategorySelected: { category, selectedItemIds, onItemsSelected in
                onCategorySelectedParameters.append((category, selectedItemIds, onItemsSelected))
            },
                                        onCheckoutTapped: { total in
                onCheckoutTappedParameters.append(total)
            })
        }

        describe("#didSelectCategory") {

            context("when id is invalid") {
                beforeEach {
                    sut.didSelectCategory(-1)
                }
                it("does Not call onCategorySelected closure") {
                    expect(onCategorySelectedParameters.count) == 0
                }
            }

            context("when id is valid") {
                beforeEach {
                    networkMock.stubResult = .success([Category.stub()])
                    awaitLoadData()

                    sut.didSelectCategory(1)
                }

                it("calls onCategorySelected closure with correct parameters") {
                    expect(onCategorySelectedParameters.count) == 1
                    expect(onCategorySelectedParameters.first?.category) == .stub()
                    expect(onCategorySelectedParameters.first?.selectedItemIds.count) == 0
                }

                context("when onItemsSelected closure is called") {
                    beforeEach {
                        onCategorySelectedParameters.first?.onItemsSelected?([.stub()])
                    }
                    it("calls adapter adapt with correct parameter") {
                        let parameters = [Category.stub(selectedItems: [.stub()])]
                        expect(adapterSpy.adaptParameters.last).toEventually(equal(parameters))
                    }
                    it("sets state correctly") {
                        verify(sut.$state, equals: [
                            .ready(.stub())
                        ])
                    }
                }
            }
        }

        describe("#didTapCheckout") {
            beforeEach {
                networkMock.stubResult = .success([Category.stub()])
                awaitLoadData()
                sut.didSelectCategory(1)
                onCategorySelectedParameters.first?.onItemsSelected?([.stub()])

                sut.didTapCheckout()
            }

            it("calls formatter formatTotal with correct parameter") {
                expect(formatterSpy.formatTotalParameters.count) == 1
                expect(formatterSpy.formatTotalParameters.first?.minTotal) == 1
                expect(formatterSpy.formatTotalParameters.first?.maxTotal) == 3
            }
            it("calls onCheckoutTapped closure with correct parameter") {
                expect(onCheckoutTappedParameters) == ["$1,234-5,678"]
            }
        }

        describe("#loadData") {
            justBeforeEach {
                sut.loadData()
            }

            context("when result is failure") {
                it("calls network fetch with correct parameter") {
                    expect(networkMock.fetchParameters.count) == 1
                    expect(networkMock.fetchParameters.first).to(beAKindOf(CategoriesRequest.self))
                }
                it("sets state correctly") {
                    verify(sut.$state, equals: [
                        .loading,
                        .error(message: "The operation couldn’t be completed. (CleanNetwork.CLError error 0.)")
                    ])
                }
            }

            context("when result is success") {
                beforeEach {
                    networkMock.stubResult = .success([Category.stub()])
                }
                it("calls network fetch with correct parameter") {
                    expect(networkMock.fetchParameters.count) == 1
                    expect(networkMock.fetchParameters.first).to(beAKindOf(CategoriesRequest.self))
                }
                it("calls adapter adapt with correct parameter") {
                    expect(adapterSpy.adaptParameters).toEventually(equal([[.stub()]]))
                }
                it("sets state correctly") {
                    verify(sut.$state, equals: [
                        .loading,
                        .ready(.stub())
                    ])
                }
            }
        }

        func awaitLoadData(file: FileString = #file,
                           line: UInt = #line) {
            sut.loadData()
            Nimble.waitUntil(file: file, line: line) { done in
                sut.$state
                    .first {
                        if case .ready(_) = $0 {
                            done()
                            return true
                        }
                        return false
                    }
                    .sink { _ in }
                    .store(in: &subcriptions)
            }
        }

        func verify<T: Equatable>(_ propertyPublisher: Published<T>.Publisher,
                                  equals expectedValues: [T],
                                  file: FileString = #file,
                                  line: UInt = #line) {
            var values = [T]()
            propertyPublisher
                .sink { values.append($0) }
                .store(in: &subcriptions)
            expect(values).toEventually(equal(expectedValues))
        }
    }
}
