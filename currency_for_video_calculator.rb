class CurrencyForVideoCalculator
  def initialize(amount, currency)
    @amount = amount
    @currency = currency
  end

  def calculate
    BigDecimal(LAZY_CURRENCY_TO_YEN[@currency]) * @amount
  end

  private

  EARLY_STREAMS_TO_USE_LAZY_CURRENCY = [
    "P_YXAukoH2I",
    "pMmp2zdYeDQ",
    "_aQP-MXCdxY",
    "5D4fZcpUhh0",
    "17j8Ffq9w_A",
    "99qRgraFNcs",
    "dtVKZ5cCRzQ",
    "8UJp9Dz6MTI",
    "cKlizEm6u1U",
    "RVYeZOV-tnc",
    "qnHD4MnRCtA",
    "TcpwehZlG24",
    "MEvwyVRHITw",
    "VN8UpQpGigg",
    "BZR64EF3cI4",
    "LHw1TRsuasM",
    "N6TwgX7MDh0",
    "XEjKMUgpFDg",
    "Yfc8lSVVm7Q",
    "IjnGeSjOMPw",
    "m-ge6iF6AAU",
    "ql71CjY3fak",
    "GFeVb1Ym5tA",
    "mf-5KS2B74o",
    "1oVZ-Pw74-o",
    "RRWmslduUXM",
    "u8T2rTcoqkA",
    "fLYWYlvfERg",
    "qcCbCnEkkyk",
    "364J6DW9REE",
    "GTmts5-tK-g",
    "UiL5SlkeX8U",
    "omDeVOYzi2k",
    "WKR9mo0mK9E",
    "gwesvHli5ws",
    "5BJlj6_AbQk",
    "eqgMAIsPPVA",
    "gckzzGamhHI",
    "Vs4TSgJcuwA",
    "RhUhmrB4fbA",
    "kFiHvRRl05M",
    "azaDulPxKr4"
  ]

  LAZY_CURRENCY_TO_YEN = {
    "$" => "107.00",
    "RON " => "26.50",
    "SEK " => "12.90",
    "HRK " => "17.30",
    "BGN " => "66.80",
    "RUB " => "1.45",
    "CA$" => "86.90",
    "PLN " => "28.00",
    "€" => "129.50",
    "ARS " => "1.18",
    "₹" => "1.47",
    "MX$" => "5.30",
    "₱" => "2.23",
    "A$" => "83.60",
    "£" => "149.20",
    "SGD " => "80.6",
    "R$" => "19.90"
  }
end
