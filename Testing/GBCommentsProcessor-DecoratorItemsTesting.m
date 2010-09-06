//
//  GBCommentsProcessor-DecoratorItemsTesting.m
//  appledoc
//
//  Created by Tomaz Kragelj on 2.9.10.
//  Copyright (C) 2010 Gentle Bytes. All rights reserved.
//

#import "GBComment.h"
#import "GBCommentsProcessor.h"

#pragma mark -

@interface GBCommentsProcessorDecoratorItemsBoldTesting : GBObjectsAssertor @end
@implementation GBCommentsProcessorDecoratorItemsBoldTesting

- (void)testProcesCommentWithStore_shouldGenerateParagraphIfNoneSpecifiedBefore {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"*text*"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"text", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectAtTheStartOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"*text* normal"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"text", [GBParagraphTextItem class], @"normal", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectAtTheEndOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"normal *text*"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphTextItem class], @"normal", [GBParagraphDecoratorItem class], @"text", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:1] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectInTheMiddleOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"prefix *text* suffix"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphTextItem class], @"prefix", [GBParagraphDecoratorItem class], @"text", [GBParagraphTextItem class], @"suffix", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:1] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectWhitespaceSeparatedWords {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"*bla word\ttab\nline*"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"bla word tab line", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"bla word tab line", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"bla word tab line", nil];
}

@end

#pragma mark -

@interface GBCommentsProcessorDecoratorItemsItalicsTesting : GBObjectsAssertor @end
@implementation GBCommentsProcessorDecoratorItemsItalicsTesting

- (void)testProcesCommentWithStore_shouldGenerateParagraphIfNoneSpecifiedBefore {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"_text_"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"text", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectAtTheStartOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"_text_ normal"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"text", [GBParagraphTextItem class], @"normal", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectAtTheEndOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"normal _text_"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphTextItem class], @"normal", [GBParagraphDecoratorItem class], @"text", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:1] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectInTheMiddleOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"prefix _text_ suffix"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphTextItem class], @"prefix", [GBParagraphDecoratorItem class], @"text", [GBParagraphTextItem class], @"suffix", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:1] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectWhitespaceSeparatedWords {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"_bla word\ttab\nline_"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"bla word tab line", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"bla word tab line", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"bla word tab line", nil];
}

@end

#pragma mark -

@interface GBCommentsProcessorDecoratorItemsBoldItalicsTesting : GBObjectsAssertor @end
@implementation GBCommentsProcessorDecoratorItemsBoldItalicsTesting

- (void)testProcesCommentWithStore_shouldGenerateParagraphIfNoneSpecifiedBefore {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"_*text*_"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"text", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"text", 
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectAtTheStartOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"_*text*_ normal"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"text", [GBParagraphTextItem class], @"normal", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"text", 
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectAtTheEndOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"normal _*text*_"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphTextItem class], @"normal", [GBParagraphDecoratorItem class], @"text", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:1] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"text", 
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectInTheMiddleOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"prefix _*text*_ suffix"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphTextItem class], @"prefix", [GBParagraphDecoratorItem class], @"text", [GBParagraphTextItem class], @"suffix", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:1] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"text", 
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectWhitespaceSeparatedWords {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"_*bla word\ttab\nline*_"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"bla word tab line", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeBold, @"bla word tab line", 
	 [GBParagraphDecoratorItem class], GBDecorationTypeItalics, @"bla word tab line", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"bla word tab line", nil];
}

@end

#pragma mark -

@interface GBCommentsProcessorDecoratorItemsCodeTesting : GBObjectsAssertor @end
@implementation GBCommentsProcessorDecoratorItemsCodeTesting

- (void)testProcesCommentWithStore_shouldGenerateParagraphIfNoneSpecifiedBefore {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"`text`"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"text", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeCode, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectAtTheStartOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"`text` normal"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"text", [GBParagraphTextItem class], @"normal", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeCode, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectAtTheEndOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"normal `text`"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphTextItem class], @"normal", [GBParagraphDecoratorItem class], @"text", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:1] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeCode, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectInTheMiddleOfParagraph {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"prefix `text` suffix"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphTextItem class], @"prefix", [GBParagraphDecoratorItem class], @"text", [GBParagraphTextItem class], @"suffix", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:1] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeCode, @"text", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"text", nil];
}

- (void)testProcesCommentWithStore_shouldDetectWhitespaceSeparatedWords {
	// setup
	GBCommentsProcessor *processor = [GBCommentsProcessor processorWithSettingsProvider:[GBTestObjectsRegistry mockSettingsProvider]];
	GBComment *comment = [GBComment commentWithStringValue:@"`bla word\ttab\nline`"];
	// execute
	[processor processComment:comment withStore:[GBTestObjectsRegistry store]];
	// verify
	assertThatInteger([comment.paragraphs count], equalToInteger(1));
	[self assertParagraph:[comment.paragraphs objectAtIndex:0] containsItems:[GBParagraphDecoratorItem class], @"bla word tab line", nil];
	[self assertDecoratedItem:[[[comment.paragraphs objectAtIndex:0] items] objectAtIndex:0] describesHierarchy:
	 [GBParagraphDecoratorItem class], GBDecorationTypeCode, @"bla word tab line", 
	 [GBParagraphTextItem class], GBDecorationTypeNone, @"bla word tab line", nil];
}

@end
