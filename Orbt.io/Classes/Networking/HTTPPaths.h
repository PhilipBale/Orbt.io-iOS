//
//  HTTPPaths.h
//  Pods
//
//  Created by Philip Bale on 11/12/16.
//
//

#ifndef HTTPPaths_h
#define HTTPPaths_h

#define BASE_API_URL @"http://orbt.io"

#define API_PATH(PATH) (BASE_API_URL @"/" #PATH)

#define kAPIAttempts 2
#define kAPIAttemptDelay 1.50

static NSString * const kApiPathAllConversations = API_PATH(conversations);
static NSString * const kApiPathMessagesForConversation = API_PATH(conversations);
static NSString * const kApiPathCheckCredentials = API_PATH(users);

#endif /* HTTPPaths_h */
