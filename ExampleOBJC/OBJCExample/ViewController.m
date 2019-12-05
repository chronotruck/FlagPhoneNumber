//
//  ViewController.m
//  OBJCExample
//
//  Created by Aurelien on 28/05/2019.
//  Copyright © 2019 chronotruck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <FPNTextFieldDelegate>

@property (strong, nonatomic) FPNTextField *phoneNumberTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.

		//		NSBundle.FlagIcons = [NSBundle bundleForClass: [self class]];
	_phoneNumberTextField = [[FPNTextField alloc] initWithFrame: CGRectMake(0, 0, self.view.bounds.size.width - 16, 50)];
	_phoneNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
	_phoneNumberTextField.displayMode = 0;
	_phoneNumberTextField.delegate = self;
		//	_phoneNumberTextField.flagSize = CGSizeMake(35, 35);
		//	_phoneNumberTextField.flagButtonEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
	_phoneNumberTextField.hasPhoneNumberExample = TRUE;
		//	_phoneNumberTextField.placeholder = @"Phone Number";
		//	[_phoneNumberTextField setCountriesIncluding: @[@(FPNOBJCCountryKeyAM),@(FPNOBJCCountryKeyBW),@(FPNOBJCCountryKeyBA)]];
		//	[_phoneNumberTextField setCountriesWithExcluding: @[@(FPNOBJCCountryKeyAM),@(FPNOBJCCountryKeyBW),@(FPNOBJCCountryKeyBA)]];
		//	[_phoneNumberTextField setFlagFor: FPNOBJCCountryKeyFR];
	[_phoneNumberTextField setWithPhoneNumber: @"+33612345678"];

	[self.view addSubview: _phoneNumberTextField];

	_phoneNumberTextField.center = self.view.center;
}

- (void)fpnDidSelectCountryWithName:(NSString * _Nonnull)name dialCode:(NSString * _Nonnull)dialCode code:(NSString * _Nonnull)code {
	NSLog(@"%@ %@ %@", name, dialCode, code);
}

- (void)fpnDidValidatePhoneNumberWithTextField:(FPNTextField * _Nonnull)textField isValid:(BOOL)isValid {
	UIImage *img = isValid ? [UIImage imageNamed: @"success"] : [UIImage imageNamed: @"error"];

	_phoneNumberTextField.rightViewMode = UITextFieldViewModeAlways;
	_phoneNumberTextField.rightView = [[UIImageView alloc] initWithImage: img];

	NSLog(@"is valid: %@", isValid ? @"Yes" : @"No");
	NSLog(@"E164 Format: %@", [_phoneNumberTextField getFormattedPhoneNumberWithFormat: FPNFormatE164]);
	NSLog(@"International Format: %@", [_phoneNumberTextField getFormattedPhoneNumberWithFormat: FPNFormatInternational]);
	NSLog(@"National Format: %@", [_phoneNumberTextField getFormattedPhoneNumberWithFormat: FPNFormatNational]);
	NSLog(@"RFC3966 Format: %@", [_phoneNumberTextField getFormattedPhoneNumberWithFormat: FPNFormatRFC3966]);
	NSLog(@"Raw: %@", [_phoneNumberTextField getRawPhoneNumber]);
}

- (void)fpnDisplayCountryList {

}

@end
