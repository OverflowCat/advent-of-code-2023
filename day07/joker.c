#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *CARD_LEXI_ORDER_JOKER = "AKQT98765432J";

typedef enum
{
    INVALID_HAND,
    FIVE_OF_A_KIND,
    FOUR_OF_A_KIND,
    FULL_HOUSE,
    THREE_OF_A_KIND,
    TWO_PAIR,
    ONE_PAIR,
    HIGH_CARD
} HandType;

HandType determineHandType(const char *hand)
{
    int length = strlen(hand);
    if (length != 5)
        return INVALID_HAND;

    short unsigned freq[128] = {0};
    for (size_t i = 0; i < length; ++i)
    {
        freq[(size_t)hand[i]]++;
    }

    unsigned short pairs = 0, threes = 0, fours = 0, fives = 0, jokers = freq['J'];
    for (unsigned short i = '2'; i <= 'T'; ++i)
    {
        if (i == 'J') // JJJJJ
            continue;
        if (freq[i] == 5)
        {
            fives++;
            break;
        }
        if (freq[i] == 4)
        {
            fours++;
            break;
        }
        if (freq[i] == 3)
        {
            threes++;
        }
        if (freq[i] == 2)
        {
            pairs++;
        }
    }

    if (jokers)
        printf(" %s", hand);
    while (jokers)
    {
        if (jokers == 5) // JJJJJ
            return FIVE_OF_A_KIND;
        if (fours)
        {
            fives++;
            fours--;
        }
        else if (threes)
        {
            fours++;
            threes--;
        }
        else if (pairs)
        {
            threes++;
            pairs--;
        }
        else
        {
            pairs++;
        }
        jokers--;
    }

    if (fives == 1)
        return FIVE_OF_A_KIND;
    if (fours == 1)
        return FOUR_OF_A_KIND;
    if (threes == 1 && pairs == 1)
        return FULL_HOUSE;
    if (threes == 1)
        return THREE_OF_A_KIND;
    if (pairs == 2)
        return TWO_PAIR;
    if (pairs == 1)
        return ONE_PAIR;
    return HIGH_CARD;
}

typedef struct
{
    char name[6];
    unsigned weight;
    HandType type;
} Hand;

int cstrcmp(const void *a, const void *b)
{
    char *strA = (char *)a;
    char *strB = (char *)b;
    for (int i = 0; i < 5; ++i)
    {
        int indexA = strchr(CARD_LEXI_ORDER_JOKER, strA[i]) - CARD_LEXI_ORDER_JOKER;
        int indexB = strchr(CARD_LEXI_ORDER_JOKER, strB[i]) - CARD_LEXI_ORDER_JOKER;
        if (indexA != indexB)
            return indexA - indexB;
    }
}

int compareHands(const void *a, const void *b)
{
    Hand *handA = (Hand *)a;
    Hand *handB = (Hand *)b;
    if (handA->type != handB->type)
        return handA->type - handB->type;
    // compare name lexicographically (custom)
    return cstrcmp(handA->name, handB->name);
}

int main()
{
    Hand hands[1000];
    size_t i = 0;
    FILE *fp = fopen("input.txt", "r");
    while (1)
    {
        Hand hand;
        fscanf(fp, "%s %u", hand.name, &hand.weight);
        if (strcmp(hand.name, "end") == 0)
            break;
        hand.type = determineHandType(hand.name);

        hands[i++] = hand;
    }

    qsort(hands, i, sizeof(Hand), compareHands);
    printf("\n");

    unsigned total = 0;
    for (size_t j = 0; j < i; ++j)
    {
        size_t rank = 1000 - j;
        total += rank * hands[j].weight;
        printf("%s %u\n", hands[j].name, hands[j].weight);
    }
    printf("\ntotal winnings: %u\n", total);
}
