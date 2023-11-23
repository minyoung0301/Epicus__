package magic;

public class characters {
	private int id;
	private String image_path;
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getExplanationInput() {
		return explanationInput;
	}
	public void setExplanationInput(String explanationInput) {
		this.explanationInput = explanationInput;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPlaceInput() {
		return placeInput;
	}
	public void setPlaceInput(String placeInput) {
		this.placeInput = placeInput;
	}
	public String getAgeInput() {
		return ageInput;
	}
	public void setAgeInput(String ageInput) {
		this.ageInput = ageInput;
	}
	public String getResidenceInput() {
		return residenceInput;
	}
	public void setResidenceInput(String residenceInput) {
		this.residenceInput = residenceInput;
	}
	public String getGenderInput() {
		return genderInput;
	}
	public void setGenderInput(String genderInput) {
		this.genderInput = genderInput;
	}
	public String getJobInput() {
		return jobInput;
	}
	public void setJobInput(String jobInput) {
		this.jobInput = jobInput;
	}
	public String getBirthdayInput() {
		return birthdayInput;
	}
	public void setBirthdayInput(String birthdayInput) {
		this.birthdayInput = birthdayInput;
	}
	public String getNicknameInput() {
		return nicknameInput;
	}
	public void setNicknameInput(String nicknameInput) {
		this.nicknameInput = nicknameInput;
	}
	public String getPersonalityInput() {
		return personalityInput;
	}
	public void setPersonalityInput(String personalityInput) {
		this.personalityInput = personalityInput;
	}
	public String getAppearanceInput() {
		return appearanceInput;
	}
	public void setAppearanceInput(String appearanceInput) {
		this.appearanceInput = appearanceInput;
	}
	public String getTalentInput() {
		return talentInput;
	}
	public void setTalentInput(String talentInput) {
		this.talentInput = talentInput;
	}
	public String getAdvantageInput() {
		return advantageInput;
	}
	public void setAdvantageInput(String advantageInput) {
		this.advantageInput = advantageInput;
	}
	public String getRoleInput() {
		return roleInput;
	}
	public void setRoleInput(String roleInput) {
		this.roleInput = roleInput;
	}
	public String getHobbyInput() {
		return hobbyInput;
	}
	public void setHobbyInput(String hobbyInput) {
		this.hobbyInput = hobbyInput;
	}
	public String getEtcInput() {
		return etcInput;
	}
	public void setEtcInput(String etcInput) {
		this.etcInput = etcInput;
	}
	private String userID;
	private String explanationInput;
	private String name;
	private String placeInput;
	private String ageInput;	
	private String residenceInput;
	private String genderInput;
	private String jobInput;
	private String birthdayInput;
	private String nicknameInput;
	private String personalityInput;
	private String appearanceInput;
	private String talentInput;
	private String advantageInput;
	private String roleInput;
	private String hobbyInput;
	private String etcInput;

	public characters(int id,String userID, String image_path, String explanationInput, String name, String placeInput, String ageInput,
            String residenceInput, String genderInput, String jobInput, String birthdayInput, String nicknameInput,
            String personalityInput, String appearanceInput, String talentInput, String advantageInput, String roleInput,
            String hobbyInput, String etcInput) {
this.id = id;
this.image_path = image_path;
this.userID = userID;
this.explanationInput = explanationInput;
this.name = name;
this.placeInput = placeInput;
this.ageInput = ageInput;
this.residenceInput = residenceInput;
this.genderInput = genderInput;
this.jobInput = jobInput;
this.birthdayInput = birthdayInput;
this.nicknameInput = nicknameInput;
this.personalityInput = personalityInput;
this.appearanceInput = appearanceInput;
this.talentInput = talentInput;
this.advantageInput = advantageInput;
this.roleInput = roleInput;
this.hobbyInput = hobbyInput;
this.etcInput = etcInput;
}
}
