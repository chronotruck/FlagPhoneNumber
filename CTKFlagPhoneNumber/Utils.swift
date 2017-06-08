// Welcome on board !                                               _______________________________________________
// This source is not the funniest part of what we do              |                                               | |\
// Want to know more ? matthieu@chronotruck.com                    |                                               | ||
//  ____ _                           _                   _         |                                               |,""---:___
// / ___| |__  ____ ___  _ __   ___ | |_ _ __ _   _  ___| | __     |                                               ||==  | .-.|
// | |  | '_ \| __// _ \| '_ \ / _ \| __| '__| | | |/ __| |/ /     |                                               ||==  | '-'-----.
// | |__| | | | | | (_) | | | | (_) | |_| |  | |_| | (__|   <      |_______________________________________________||    |~  |   -(|
// \____|_| |_|_|  \___/|_| |_|\___/ \__|_|   \__,_|\___|_|\_\     |_____________________________/<  _...==...____|    |   | ___ |
//                                                                  \\ .-.  .-. //            \|  \//.-.  .-.\\ --------"-"/.-.\_]
//                                                                  ` ( o )( o )'              '    ( o )( o )`"""""""""==`( o )
//                                                                     '-'  '-'                      '-'  '-'               '-'

//  Created by Aurélien GRIFASI on 07/06/2017.

import Foundation

/**
This function returns a tool bar for AccessoryInputView
*/
func getToolBar(_ target: Any, title: String, selector: Selector) -> UIToolbar {
	let doneToolbar: UIToolbar = UIToolbar()
	let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
	let done: UIBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.done, target: target, action: selector)
	
	doneToolbar.barStyle = UIBarStyle.default
	doneToolbar.items = [flexSpace, done]
	doneToolbar.sizeToFit()
	
	return doneToolbar
}
