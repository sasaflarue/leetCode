//You are given an array prices where prices[i] is the price of a given stock on the ith day.
//
//You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.
//
//Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.


class Solution {
    static func maxProfit(_ prices: [Int]) -> Int {
        var curProfit = 0
        var buyPrice = prices.first ?? 0 //7, 1
        prices.forEach {
            if $0 < buyPrice {
                buyPrice = $0
            } else if ($0 - buyPrice) > curProfit {
                curProfit = $0 - buyPrice
            }
        }
        return curProfit
    }
}


let prices = [7,1,5,3,6,4] //expected 5
print(Solution.maxProfit(prices))

let prices2 = [7,6,4,3,1] // expected 0
print(Solution.maxProfit(prices2))

