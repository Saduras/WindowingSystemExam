package basicUI;

/**
 * String validator for the InputField. Can validate: text, integer (number), float, color, address
 * @author David
 */
class StringValidator
{
	var regText : EReg;
	var regNumber : EReg;
	var regFloat : EReg;
	var regColor : EReg;
	var regColor2 : EReg;
	var regAddress : EReg;
	public var modus : String = "text";
	
	public function new(modus : String) 
	{
		regText = ~/^[a-zA-Z]+$/;
		regNumber = ~/^[0-9]+$/;
		regFloat  = ~/^[0-9]+\.[0-9]+$/;
		regColor = ~/^#[0-9A-Fa-f]{3}$/;
		regColor2 = ~/^#[0-9A-Fa-f]{6}$/;
		regAddress = ~/^([A-Z]{1}+[a-z]+[ ]){1,}+[0-9]+[a-z]{0,1}+$/;
		this.modus = modus;
	}
	
	public function checkText (text : String ) : Bool
	{
		switch(modus) {
			case "text":
				if (regText.match(text))
				{
					return true;
				}
			case "number":
				if (regNumber.match(text))
				{
					return true;
				}
			case "float":
				if (regFloat.match(text))
				{
					return true;
				}
			case "color":
				if (regColor.match(text) || regColor2.match(text))
				{
					return true;
				}
			case "address":
				if (regAddress.match(text))
				{
					return true;
				}
		}
		
		return false;
	}
	
}