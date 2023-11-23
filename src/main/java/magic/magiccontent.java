package magic;

import java.sql.Timestamp;

public class magiccontent {
	private int magicID;
	public int getMagicID() {
		return magicID;
	}
	public void setMagicID(int magicID) {
		this.magicID = magicID;
	}
	public int getRoundID() {
		return roundID;
	}
	public void setRoundID(int roundID) {
		this.roundID = roundID;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getGenres() {
		return genres;
	}
	public void setGenres(String genres) {
		this.genres = genres;
	}
	public String getGenre_opinion() {
		return genre_opinion;
	}
	public void setGenre_opinion(String genre_opinion) {
		this.genre_opinion = genre_opinion;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getKeyword_opinion() {
		return keyword_opinion;
	}
	public void setKeyword_opinion(String keyword_opinion) {
		this.keyword_opinion = keyword_opinion;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getSpace() {
		return space;
	}
	public void setSpace(String space) {
		this.space = space;
	}
	public String getTime_opinion() {
		return time_opinion;
	}
	public void setTime_opinion(String time_opinion) {
		this.time_opinion = time_opinion;
	}
	public String getSpace_opinion() {
		return space_opinion;
	}
	public void setSpace_opinion(String space_opinion) {
		this.space_opinion = space_opinion;
	}
	public String getNatural_opinion() {
		return natural_opinion;
	}
	public void setNatural_opinion(String natural_opinion) {
		this.natural_opinion = natural_opinion;
	}
	public String getSocial_opinion() {
		return social_opinion;
	}
	public void setSocial_opinion(String social_opinion) {
		this.social_opinion = social_opinion;
	}
	public String getPsychological_opinion() {
		return psychological_opinion;
	}
	public void setPsychological_opinion(String psychological_opinion) {
		this.psychological_opinion = psychological_opinion;
	}
	public String getSituational_opinion() {
		return situational_opinion;
	}
	public void setSituational_opinion(String situational_opinion) {
		this.situational_opinion = situational_opinion;
	}
	public String getOther_opinion() {
		return other_opinion;
	}
	public void setOther_opinion(String other_opinion) {
		this.other_opinion = other_opinion;
	}
	public String getInternal_opinion() {
		return internal_opinion;
	}
	public void setInternal_opinion(String internal_opinion) {
		this.internal_opinion = internal_opinion;
	}
	public String getExternal_opinion() {
		return external_opinion;
	}
	public void setExternal_opinion(String external_opinion) {
		this.external_opinion = external_opinion;
	}
	public String getTrack_opinion() {
		return track_opinion;
	}
	public void setTrack_opinion(String track_opinion) {
		this.track_opinion = track_opinion;
	}
	public String getSub_opinion() {
		return sub_opinion;
	}
	public void setSub_opinion(String sub_opinion) {
		this.sub_opinion = sub_opinion;
	}
	public String getStory_opinion() {
		return story_opinion;
	}
	public void setStory_opinion(String story_opinion) {
		this.story_opinion = story_opinion;
	}
	public String getMain_opinion() {
		return main_opinion;
	}
	public void setMain_opinion(String main_opinion) {
		this.main_opinion = main_opinion;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public Timestamp getMagicDate() {
		return magicDate;
	}
	public void setMagicDate(Timestamp magicDate) {
		this.magicDate = magicDate;
	}
	public int getAvailable() {
		return Available;
	}
	public void setAvailable(int available) {
		Available = available;
	}
	public int getMagiccheck() {
		return magiccheck;
	}
	public void setMagiccheck(int magiccheck) {
		this.magiccheck = magiccheck;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}

	public int getCharacter_id() {
		return character_id;
	}
	public void setCharacter_id(int character_id) {
		this.character_id = character_id;
	}
	private int roundID;
	private int number;
	private String genres;
	private String genre_opinion;
	private String keyword;
	private String keyword_opinion;
	private String time;
	private String space;
	private String time_opinion;
	
	private String space_opinion;
	private String natural_opinion;
	private String social_opinion;
	private String psychological_opinion;
	private String situational_opinion;
	private String other_opinion;
	private String internal_opinion;	
	private String external_opinion;
	private String track_opinion;
	private String sub_opinion;
	
	private String story_opinion;
	private String main_opinion;
	private String userID;
	private Timestamp magicDate;
	private int Available;
	private int magiccheck;
	private int hit;
	private int like_count;
	
	private int character_id;
	
	public magiccontent(int magicID, int roundID, int number, String genres, String genre_opinion,
            String keyword, String keyword_opinion, String time, String space, String time_opinion,
            String space_opinion, String natural_opinion, String social_opinion,
            String psychological_opinion, String situational_opinion, String other_opinion,
            String internal_opinion, String external_opinion, String track_opinion,
            String sub_opinion, String story_opinion, String main_opinion, String userID,
            int like_count, Timestamp magicDate, int Available, int magiccheck, int hit,
            int character_id) {
// 생성자 내부에서 필드 초기화 및 다른 작업 수행
this.magicID = magicID;
this.roundID = roundID;
this.number = number;
this.genres = genres;
this.genre_opinion = genre_opinion;
this.keyword = keyword;
this.keyword_opinion = keyword_opinion;
this.time = time;
this.space = space;
this.time_opinion = time_opinion;
this.space_opinion = space_opinion;
this.natural_opinion = natural_opinion;
this.social_opinion = social_opinion;
this.psychological_opinion = psychological_opinion;
this.situational_opinion = situational_opinion;
this.other_opinion = other_opinion;
this.internal_opinion = internal_opinion;
this.external_opinion = external_opinion;
this.track_opinion = track_opinion;
this.sub_opinion = sub_opinion;
this.story_opinion = story_opinion;
this.main_opinion = main_opinion;
this.userID = userID;
this.like_count = like_count;
this.magicDate = magicDate;
this.Available = Available;
this.magiccheck = magiccheck;
this.hit = hit;

this.character_id = character_id;
}
}
