//
//  FSRecipe.m
//  Pods
//
//  Created by Poulose Matthen on 06/08/14.
//
//

#import "FSRecipe.h"
#import "FSServing.h"

@implementation FSRecipe

- (id) initWithJSON:(NSDictionary *)json {
	self = [super init];
	if (self) {
		_name            = [json objectForKey:@"recipe_name"];
		_recipeDescription = [json objectForKey:@"recipe_description"];
		_url			 = [json objectForKey:@"recipe_url"];
		_identifier		 = [[json objectForKey:@"recipe_id"] integerValue];
		
		id servings = [json objectForKey:@"servings"];
		
		_servings = @[];
		
		if (servings) {
			servings = [servings objectForKey:@"serving"];
			
			// This is a hack to figure out if servings is an array or a dictionary
			// since the API returns a dictionary if there's only one serving (WTF?)
			if ([servings respondsToSelector:@selector(arrayByAddingObject:)]) {
				NSMutableArray *array = [@[] mutableCopy];
				for (NSDictionary *serving in servings) {
					[array addObject:[FSServing servingWithJSON:serving]];
				}
				_servings = array;
			} else {
				if ([servings count] == 0) {
					_servings = @[];
				} else {
					_servings = @[ [FSServing servingWithJSON:servings] ];
				}
			}
		}
	}
	
	return self;
}

+ (id) recipeWithJSON:(NSDictionary *)json {
	return [[self alloc] initWithJSON:json];
}


@end
