//******************************************************************************
//
// Copyright (c) 2015 Microsoft Corporation. All rights reserved.
//
// This code is licensed under the MIT License (MIT).
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//******************************************************************************

#include "Starboard.h"
#include "UIKit/UIKit.h"
#include "UIKit/UIView.h"
#include "UIKit/UITextField.h"
#include "UIKit/UIColor.h"
#include "UIKit/UILabel.h"
#include "UIKit/UIFont.h"
#include "UIKit/UIImage.h"
#include "UIKit/UISegmentedControl.h"

static const CGFloat c_marginBottom = 10;
static const CGFloat c_marginLeftAndRight = 10;
static const CGFloat c_defaultTextFieldHeight = 24;
static const CGFloat c_marginTopForPrompt = 10;
static const float c_defaultFontSize = 15.0;
static const CGFloat c_scopeButtonMarginTop = 20;

@implementation UISearchBar {
    idretaintype(UITextField) _textField;
    idretaintype(UILabel) _promptLabel;
    idretaintype(UISegmentedControl) _scopeButtons;
    idretaintype(NSString) _placeholder;
    BOOL _scopeButtonsHidden;
    id _delegate;
}

static void initInternal(UISearchBar* self) {
    CGRect frame = [self frame];
    self->_textField.attach([[UITextField alloc] initWithFrame:frame]);
    [self->_textField setDelegate:(id<UITextFieldDelegate>)self];
    [self->_textField setBorderStyle:UITextBorderStyleRoundedRect];
    [self->_textField addTarget:self action:@selector(onTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self->_textField setFont:[UIFont systemFontOfSize:c_defaultFontSize]];
    if (self->_placeholder != nil) {
        [self->_textField setPlaceholder:self->_placeholder];
    }
    [self addSubview:self->_textField];

    UIImage* navGradient = [[UIImage imageNamed:@"/img/navgradient-default.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    UIImageSetLayerContents([self layer], navGradient);
}

- (BOOL)resignFirstResponder {
    return [_textField resignFirstResponder];
}

/**
 @Status Interoperable
*/
- (void)setPrompt:(NSString*)prompt {
    if (_promptLabel == nil) {
        CGRect promptFrame = CGRectMake(0, c_marginTopForPrompt, self.frame.size.width, c_defaultTextFieldHeight);

        self->_promptLabel.attach([[UILabel alloc] initWithFrame:promptFrame]);
        [self->_promptLabel setTextAlignment:NSTextAlignmentCenter];
        [self->_promptLabel setBackgroundColor:nil];
        [self->_promptLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self->_promptLabel];
    }

    _prompt = prompt;
    [self setNeedsDisplay];
}

- (instancetype)initWithCoder:(NSCoder*)coder {
    id ret = [super initWithCoder:coder];

    // If we have scope buttons, we need to read them here:
    id scopeBarTitles = nil;
    if ([coder containsValueForKey:@"UIScopeButtonTitles"]) {
        scopeBarTitles = [coder decodeObjectForKey:@"UIScopeButtonTitles"];
    }
    _scopeButtonsHidden = true;
    if ([coder containsValueForKey:@"UIShowsScopeBar"]) {
        if ([coder decodeIntForKey:@"UIShowsScopeBar"]) {
            _scopeButtonsHidden = false;
        }
    }
    _placeholder = [coder decodeObjectForKey:@"UIPlaceholder"];

    if (scopeBarTitles) {
        _scopeButtons = [[UISegmentedControl alloc] initWithItems:scopeBarTitles];
        [self addSubview:(id)_scopeButtons];

        [_scopeButtons setSelectedSegmentIndex:0];
        [_scopeButtons addTarget:self action:@selector(scopeChanged) forControlEvents:UIControlEventValueChanged];
    }

    initInternal(self);

    return ret;
}

- (void)scopeChanged {
    if ([_delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]) {
        [_delegate searchBar:self selectedScopeButtonIndexDidChange:[_scopeButtons selectedSegmentIndex]];
    }
}

/**
 @Status Stub
*/
- (void)setAutocapitalizationType:(UITextAutocapitalizationType)type {
    UNIMPLEMENTED();
}

/**
 @Status Stub
*/
- (void)setAutocorrectionType:(UITextAutocorrectionType)type {
    UNIMPLEMENTED();
}

/**
 @Status Stub
*/
- (void)setKeyboardType:(UIKeyboardType)type {
    UNIMPLEMENTED();
}

- (instancetype)initWithFrame:(CGRect)frame {
    [super initWithFrame:frame];
    initInternal(self);

    return self;
}

/**
 @Status Interoperable
*/
- (void)setDelegate:(id)delegate {
    _delegate = delegate;
}

/**
 @Status Interoperable
*/
- (void)setText:(NSString*)text {
    [_textField setText:text];
}

/**
 @Status Interoperable
*/
- (NSString*)text {
    return [_textField text];
}

/**
 @Status Stub
*/
- (void)setShowsCancelButton:(BOOL)shows {
    UNIMPLEMENTED();
}

/**
 @Status Stub
*/
- (void)setShowsCancelButton:(BOOL)shows animated:(BOOL)animated {
    UNIMPLEMENTED();
}

/**
 @Status Stub
*/
- (void)setShowsBookmarkButton:(BOOL)shows {
    UNIMPLEMENTED();
}

/**
 @Status Stub
*/
- (void)setBarStyle:(UIBarStyle)style {
    UNIMPLEMENTED();
}

/**
 @Status Interoperable
*/
- (void)setPlaceholder:(id)placeholder {
    [_textField setPlaceholder:placeholder];
}

/**
 @Status Interoperable
*/
- (NSString*)placeholder {
    return [_textField placeholder];
}

/**
 @Status Stub
*/
- (void)setTintColor:(id)color {
    UNIMPLEMENTED();
}

- (void)setTranslucent:(BOOL)translucent {
    if (translucent) {
        [self setAlpha:0.75f];
    } else {
        [self setAlpha:1.0f];
    }
}

- (void)setShowsSearchResultsButton:(BOOL)shows {
}

/**
 @Status Stub
*/
- (void)setScopeButtonTitles:(id)titles {
    UNIMPLEMENTED();
}

- (void)setScopeBarButtonTitleTextAttributes:(id)attributes forState:(DWORD)forState {
}

- (void)layoutSubviews {
    CGRect promptFrame = CGRectMake(0, c_marginTopForPrompt, self.frame.size.width, c_defaultTextFieldHeight);
    [_promptLabel setFrame:promptFrame];
    [self->_promptLabel setText:_prompt];

    CGFloat textFieldOriginY = self.frame.size.height - c_defaultTextFieldHeight - c_marginBottom;
    CGRect textFrame = { { c_marginLeftAndRight, textFieldOriginY },
                         { self.frame.size.width - (2 * c_marginLeftAndRight), c_defaultTextFieldHeight } };

    if (!_scopeButtonsHidden) {
        if (_scopeButtons) {
            CGRect scopeButtonsFrame = textFrame;
            scopeButtonsFrame.origin.y = scopeButtonsFrame.origin.y + textFrame.size.height + c_scopeButtonMarginTop;
            [_scopeButtons setFrame:scopeButtonsFrame];
        }
    } else {
        [_scopeButtons setHidden:TRUE];
    }

    [_textField setFrame:textFrame];
}

- (BOOL)textField:(id)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)newString {
    BOOL changed = TRUE;

    if ([_delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]) {
        changed = [_delegate searchBar:self shouldChangeTextInRange:range replacementText:newString];
    }

    return changed;
}

- (void)onTextChanged:(UITextField*)textfield {
    if ([_delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [_delegate searchBar:self textDidChange:[_textField text]];
    }
}

- (BOOL)textFieldShouldReturn:(id)textField {
    if ([_delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        [_delegate searchBarSearchButtonClicked:self];
    }
    return TRUE;
}

- (void)textFieldDidBeginEditing:(id)textField {
    if ([_delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [_delegate searchBarTextDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(id)textField {
    // We can get double messages here so we need to make sure our text field is the
    // current first responder.

    // The messages can come from:
    //  - Pressing enter on the keyboard
    //  - The user resigning first respondership
    // We need to make sure this is a reasonable thing to do
    if ([_textField isFirstResponder]) {
        if ([_delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
            [_delegate searchBarTextDidEndEditing:self];
        }
    }
}

/**
 @Status Stub
*/
- (void)setBackgroundImage:(id)image {
    UNIMPLEMENTED();
}

- (void)dealloc {
    _textField = nil;
    _promptLabel = nil;
    _scopeButtons = nil;
    _placeholder = nil;
    [super dealloc];
}

/**
 @Status Stub
*/
- (void)setSearchResultsButtonSelected:(BOOL)selected {
    UNIMPLEMENTED();
}

/**
 @Status Stub
*/
- (NSInteger)selectedScopeButtonIndex {
    UNIMPLEMENTED();
    return 0;
}

/**
 @Status Stub
*/
- (void)setShowsScopeBar:(BOOL)show {
    UNIMPLEMENTED();
    if (!show) {
        _scopeButtonsHidden = true;
    } else {
        _scopeButtonsHidden = false;
    }

    [self setNeedsLayout];
}

- (void)setSearchFieldBackgroundImage:(UIImage*)image forState:(UIControlState)state {
}

/**
 @Status Stub
*/
- (void)setImage:(UIImage*)image forSearchBarIcon:(UISearchBarIcon)icon state:(UIControlState)state {
    UNIMPLEMENTED();
}

/**
 @Status Stub
*/
- (void)setBarTintColor:(UIColor*)color {
    UNIMPLEMENTED();
    [self setTintColor:color];
}
@end
