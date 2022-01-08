import Foundation

public struct Movies: Codable {

    public var active: String?
    public var adTagUri: String?
    public var ageRating: Int64?
    public var androidEnabled: String?
    public var androidtvEnabled: String?
    public var avgRating: Double?
    public var avodEnabled: String?
    public var channelId: Int64?
    public var contactEmail: String?
    public var contactName: String?
    public var contactPayment: String?
    public var contactPaymentMethod: String?
    public var contactPaymentPaid: String?
    public var contactPaymentStatus: String?
    public var contactPaymentTransno: String?
    public var contactPhone: String?
    public var contactPlace: String?
    public var contactSignDate: Date?
    public var contactSignature: String?
    public var contentRating: String?
    public var countryOfProduction: String?
    public var createdBy: String?
    public var createdOn: Date?
    public var featured: String?
    public var firetvEnabled: String?
    public var hits: Int64?
    public var image: String?
    public var iosTicketPrice: Double?
    public var lastUpdateLogin: String?
    public var metaDesc: String?
    public var metaKeywords: String?
    public var metaTitle: String?
    public var modifiedBy: String?
    public var modifiedOn: Date?
    public var movieActors: [MovieActors]?
    public var movieCrew: [MovieCrew]?
    public var movieDescription: String?
    public var movieGenres: [MovieGenres]?
    public var movieId: Int64?
    public var movieKey: String?
    public var movieName: String?
    public var movieNameEn: String?
    public var moviePoster: String?
    public var movieSongs: [MovieSongs]?
    public var movieType: String?
    public var movieViews: Int64?
    public var overallRank: Int64?
    public var parentId: Int64?
    public var ppvCommission: Int64?
    public var primaryLanguage: String?
    public var promoColor: String?
    public var promoDuration: Int64?
    public var promoLabel: String?
    public var promoUrl: String?
    public var promoViews: Int64?
    public var releaseDate: Date?
    public var releaseMonth: String?
    public var rokutvEnabled: String?
    public var runningTime: Int64?
    public var showInIos: String?
    public var streamingEndDate: Date?
    public var streamingStartDate: Date?
    public var subsCommission: Int64?
    public var svodEnabled: String?
    public var teaserDuration: Int64?
    public var teaserUrl: String?
    public var teaserViews: Int64?
    public var thumbnail: String?
    public var ticketRate: Double?
    public var trailorDuration: Int64?
    public var trailorUrl: String?
    public var trailorViews: Int64?
    public var tvodEnabled: String?
    public var usdTicketRate: Double?
    public var versionNumber: Int64?
    public var views: Int64?
    public var webMovieDetail: String?
    public var webMoviePoster: String?
    public var webStreamingNow: String?
    public var website: String?
    public var websiteEnabled: String?
    public var yearProduced: Int64?
    public var yearReleased: Int64?
    public var paymentStatus: String?
    public var playStatus: String?

    public init(active: String?, adTagUri: String?, ageRating: Int64?, androidEnabled: String?, androidtvEnabled: String?, avgRating: Double?, avodEnabled: String?, channelId: Int64?, contactEmail: String?, contactName: String?, contactPayment: String?, contactPaymentMethod: String?, contactPaymentPaid: String?, contactPaymentStatus: String?, contactPaymentTransno: String?, contactPhone: String?, contactPlace: String?, contactSignDate: Date?, contactSignature: String?, contentRating: String?, countryOfProduction: String?, createdBy: String?, createdOn: Date?, featured: String?, firetvEnabled: String?, hits: Int64?, image: String?, iosTicketPrice: Double?, lastUpdateLogin: String?, metaDesc: String?, metaKeywords: String?, metaTitle: String?, modifiedBy: String?, modifiedOn: Date?, movieActors: [MovieActors]?, movieCrew: [MovieCrew]?, movieDescription: String?, movieGenres: [MovieGenres]?, movieId: Int64?, movieKey: String?, movieName: String?, movieNameEn: String?, moviePoster: String?, movieSongs: [MovieSongs]?, movieType: String?, movieViews: Int64?, overallRank: Int64?, parentId: Int64?, ppvCommission: Int64?, primaryLanguage: String?, promoColor: String?, promoDuration: Int64?, promoLabel: String?, promoUrl: String?, promoViews: Int64?, releaseDate: Date?, releaseMonth: String?, rokutvEnabled: String?, runningTime: Int64?, showInIos: String?, streamingEndDate: Date?, streamingStartDate: Date?, subsCommission: Int64?, svodEnabled: String?, teaserDuration: Int64?, teaserUrl: String?, teaserViews: Int64?, thumbnail: String?, ticketRate: Double?, trailorDuration: Int64?, trailorUrl: String?, trailorViews: Int64?, tvodEnabled: String?, usdTicketRate: Double?, versionNumber: Int64?, views: Int64?, webMovieDetail: String?, webMoviePoster: String?, webStreamingNow: String?, website: String?, websiteEnabled: String?, yearProduced: Int64?, yearReleased: Int64?, paymentStatus: String?, playStatus: String?) {
        self.active = active
        self.adTagUri = adTagUri
        self.ageRating = ageRating
        self.androidEnabled = androidEnabled
        self.androidtvEnabled = androidtvEnabled
        self.avgRating = avgRating
        self.avodEnabled = avodEnabled
        self.channelId = channelId
        self.contactEmail = contactEmail
        self.contactName = contactName
        self.contactPayment = contactPayment
        self.contactPaymentMethod = contactPaymentMethod
        self.contactPaymentPaid = contactPaymentPaid
        self.contactPaymentStatus = contactPaymentStatus
        self.contactPaymentTransno = contactPaymentTransno
        self.contactPhone = contactPhone
        self.contactPlace = contactPlace
        self.contactSignDate = contactSignDate
        self.contactSignature = contactSignature
        self.contentRating = contentRating
        self.countryOfProduction = countryOfProduction
        self.createdBy = createdBy
        self.createdOn = createdOn
        self.featured = featured
        self.firetvEnabled = firetvEnabled
        self.hits = hits
        self.image = image
        self.iosTicketPrice = iosTicketPrice
        self.lastUpdateLogin = lastUpdateLogin
        self.metaDesc = metaDesc
        self.metaKeywords = metaKeywords
        self.metaTitle = metaTitle
        self.modifiedBy = modifiedBy
        self.modifiedOn = modifiedOn
        self.movieActors = movieActors
        self.movieCrew = movieCrew
        self.movieDescription = movieDescription
        self.movieGenres = movieGenres
        self.movieId = movieId
        self.movieKey = movieKey
        self.movieName = movieName
        self.movieNameEn = movieNameEn
        self.moviePoster = moviePoster
        self.movieSongs = movieSongs
        self.movieType = movieType
        self.movieViews = movieViews
        self.overallRank = overallRank
        self.parentId = parentId
        self.ppvCommission = ppvCommission
        self.primaryLanguage = primaryLanguage
        self.promoColor = promoColor
        self.promoDuration = promoDuration
        self.promoLabel = promoLabel
        self.promoUrl = promoUrl
        self.promoViews = promoViews
        self.releaseDate = releaseDate
        self.releaseMonth = releaseMonth
        self.rokutvEnabled = rokutvEnabled
        self.runningTime = runningTime
        self.showInIos = showInIos
        self.streamingEndDate = streamingEndDate
        self.streamingStartDate = streamingStartDate
        self.subsCommission = subsCommission
        self.svodEnabled = svodEnabled
        self.teaserDuration = teaserDuration
        self.teaserUrl = teaserUrl
        self.teaserViews = teaserViews
        self.thumbnail = thumbnail
        self.ticketRate = ticketRate
        self.trailorDuration = trailorDuration
        self.trailorUrl = trailorUrl
        self.trailorViews = trailorViews
        self.tvodEnabled = tvodEnabled
        self.usdTicketRate = usdTicketRate
        self.versionNumber = versionNumber
        self.views = views
        self.webMovieDetail = webMovieDetail
        self.webMoviePoster = webMoviePoster
        self.webStreamingNow = webStreamingNow
        self.website = website
        self.websiteEnabled = websiteEnabled
        self.yearProduced = yearProduced
        self.yearReleased = yearReleased
        self.paymentStatus = paymentStatus
        self.playStatus = playStatus
    }
}

