//******************************************************************************
//
// Copyright (c) 2016 Microsoft Corporation. All rights reserved.
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

#import <AVFoundation/AVFoundation.h>

#import <StubReturn.h>

NSString* const AVAssetImageGeneratorApertureModeCleanAperture = @"AVAssetImageGeneratorApertureModeCleanAperture";
NSString* const AVAssetImageGeneratorApertureModeProductionAperture = @"AVAssetImageGeneratorApertureModeProductionAperture";
NSString* const AVAssetImageGeneratorApertureModeEncodedPixels = @"AVAssetImageGeneratorApertureModeEncodedPixels";

@implementation AVAssetImageGenerator
/**
@Status Stub
@Notes
*/
- (instancetype)initWithAsset:(AVAsset*)asset {
    UNIMPLEMENTED();
    return StubReturn();
}

/**
@Status Stub
@Notes
*/
+ (instancetype)assetImageGeneratorWithAsset:(AVAsset*)asset {
    UNIMPLEMENTED();
    return StubReturn();
}

/**
@Status Stub
@Notes
*/
- (CGImageRef)copyCGImageAtTime:(CMTime)requestedTime actualTime:(CMTime*)actualTime error:(NSError* _Nullable*)outError {
    UNIMPLEMENTED();
    return StubReturn();
}

/**
@Status Stub
@Notes
*/
- (void)generateCGImagesAsynchronouslyForTimes:(NSArray*)requestedTimes completionHandler:(AVAssetImageGeneratorCompletionHandler)handler {
    UNIMPLEMENTED();
}

/**
@Status Stub
@Notes
*/
- (void)cancelAllCGImageGeneration {
    UNIMPLEMENTED();
}

@end
