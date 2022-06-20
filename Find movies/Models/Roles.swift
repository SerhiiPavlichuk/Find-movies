import Foundation
struct Roles : Codable {
	let creditId : String?
	let character : String?
	let episodeCount : Int?

	enum CodingKeys: String, CodingKey {

		case creditId = "credit_id"
		case character = "character"
		case episodeCount = "episode_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
		character = try values.decodeIfPresent(String.self, forKey: .character)
		episodeCount = try values.decodeIfPresent(Int.self, forKey: .episodeCount)
	}

}
