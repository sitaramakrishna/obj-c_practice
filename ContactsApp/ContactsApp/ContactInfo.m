//
//  ContactInfo.m
//  ContactsApp
//
//  Created by David Perkins on 5/9/16.
//  Copyright © 2016 David Perkins. All rights reserved.
//

#import "ContactInfo.h"

@implementation ContactInfo

-(NSArray *)recent {
 
    return @[
            @{
                @"name" : @"Matt Ryan",
                @"avatar" : @"avatar1",
                @"avatarBig" : @"avatarBig1",
                @"mobile" : @"555-123-4567",
                @"email" : @"matt.ryan@gmail.com",
                @"notes" : @"Likes to wear hates. Used to be an artist, now he's a freelance photographer who travels a lot."
            },
            @{
                @"name" : @"Stacy Chu",
                @"avatar" : @"avatar2",
                @"avatarBig" : @"avatarBig2",
                @"mobile" : @"555-123-4567",
                @"email" : @"stacy.chu@gmail.com",
                @"notes" : @"A full stack web developer for a small design firm."
            },
            @{
                @"name" : @"Barbara Denner",
                @"avatar" : @"avatar3",
                @"avatarBig" : @"avatarBig3",
                @"mobile" : @"555-123-4567",
                @"email" : @"barbara.denner@gmail.com",
                @"notes" : @"Catcher for the San Francisco Giants. A local demigod. Played college ball at Florida State. He's basically the man."
            }
    ];
}

-(NSArray *)friends {
    
    return @[
             @{
                 @"name" : @"Lauren Carson",
                 @"avatar" : @"avatar4",
                 @"avatarBig" : @"avatarBig4",
                 @"mobile" : @"555-123-4567",
                 @"email" : @"lauren.carson@gmail.com",
                 @"notes" : @"Likes to wear hates. Used to be an artist, now he's a freelance photographer who travels a lot."
             },
             @{
                 @"name" : @"Maggie Bryant",
                 @"avatar" : @"avatar5",
                 @"avatarBig" : @"avatarBig5",
                 @"mobile" : @"555-123-4567",
                 @"email" : @"maggie.bryant@gmail.com",
                 @"notes" : @"A full stack web developer for a small design firm."
             },
             @{
                 @"name" : @"Jack Hill",
                 @"avatar" : @"avatar6",
                 @"avatarBig" : @"avatarBig6",
                 @"mobile" : @"555-123-4567",
                 @"email" : @"jack.hill@gmail.com",
                 @"notes" : @"Catcher for the San Francisco Giants. A local demigod. Played college ball at Florida State. He's basically the man."
             },
             @{
                 @"name" : @"Marcus James",
                 @"avatar" : @"avatar7",
                 @"avatarBig" : @"avatarBig7",
                 @"mobile" : @"555-123-4567",
                 @"email" : @"marcus.james@gmail.com",
                 @"notes" : @"Likes to wear hates. Used to be an artist, now he's a freelance photographer who travels a lot."
             },
             @{
                 @"name" : @"Phil Harmonic",
                 @"avatar" : @"avatar8",
                 @"avatarBig" : @"avatarBig8",
                 @"mobile" : @"555-123-4567",
                 @"email" : @"philharmonic@gmail.com",
                 @"notes" : @"Likes to wear hates. Used to be an artist, now he's a freelance photographer who travels a lot."
             },
             @{
                 @"name" : @"Matt Flowers",
                 @"avatar" : @"avatar9",
                 @"avatarBig" : @"avatarBig9",
                 @"mobile" : @"555-123-4567",
                 @"email" : @"matt.flowers@gmail.com",
                 @"notes" : @"Likes to wear hates. Used to be an artist, now he's a freelance photographer who travels a lot."
             },

             ];
}



@end
