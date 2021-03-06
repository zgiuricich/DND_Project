DROP TABLE Creatures CASCADE CONSTRAINTS;
DROP TABLE Players CASCADE CONSTRAINTS;
DROP TABLE Characters CASCADE CONSTRAINTS;
DROP TABLE Campaigns CASCADE CONSTRAINTS;
DROP TABLE Quests CASCADE CONSTRAINTS;
DROP TABLE Items CASCADE CONSTRAINTS;
DROP TABLE Armor CASCADE CONSTRAINTS;
DROP TABLE Weapons CASCADE CONSTRAINTS;
DROP TABLE Abilities CASCADE CONSTRAINTS;
DROP TABLE Spells CASCADE CONSTRAINTS;
DROP TABLE Creature_Abilities CASCADE CONSTRAINTS;
DROP TABLE Creature_Items CASCADE CONSTRAINTS;
DROP TABLE Creature_Spells CASCADE CONSTRAINTS;
DROP TABLE Creature_Armor CASCADE CONSTRAINTS;
DROP TABLE Creature_Weapons CASCADE CONSTRAINTS;
DROP TABLE Character_Abilities CASCADE CONSTRAINTS;
DROP TABLE Character_Items CASCADE CONSTRAINTS;
DROP TABLE Character_Spells CASCADE CONSTRAINTS;
DROP TABLE Character_Armor CASCADE CONSTRAINTS;
DROP TABLE Character_Weapons CASCADE CONSTRAINTS;
DROP TABLE Item_Abilities CASCADE CONSTRAINTS;
DROP TABLE Armor_Abilities CASCADE CONSTRAINTS;
DROP TABLE Weapon_Abilities CASCADE CONSTRAINTS;
DROP TABLE Campaign_Owners CASCADE CONSTRAINTS;
DROP TABLE Campaign_Characters CASCADE CONSTRAINTS;

CREATE TABLE Creatures (
    CreatureId NUMBER(9),
    CreatureName VARCHAR2(50) NOT NULL,
    CreatureDescription VARCHAR2(1000) NOT NULL,
    CreatureType VARCHAR2(50) NOT NULL,
    CreatureSize VARCHAR2(50) NOT NULL,
    Alignment VARCHAR2(50) NOT NULL,
    Challenge_Rating NUMBER(2) NOT NULL,
    Armor_Class NUMBER(2) NOT NULL,
    Speed NUMBER(2) NOT NULL,
    Strength NUMBER(2) NOT NULL,
    Constitution NUMBER(2) NOT NULL,
    Dexterity NUMBER(2) NOT NULL,
    Wisdom NUMBER(2) NOT NULL,
    Intelligence NUMBER(2) NOT NULL,
    Charisma NUMBER(2) NOT NULL,
    CONSTRAINT CREATURE_PK PRIMARY KEY (CreatureId)
);

CREATE TABLE Players (
    PlayerId NUMBER(9),
    FullName VARCHAR2(50) NOT NULL,
    UserName VARCHAR2(50) UNIQUE NOT NULL,
    UserPassword VARCHAR2(50) NOT NULL,
    Email VARCHAR2(50) UNIQUE NOT NULL,
    CONSTRAINT PLAYER_PK PRIMARY KEY (PlayerId)
);

CREATE TABLE Characters (
    CharacterId NUMBER(9),
    OwnerId NUMBER(9),
    CharacterName VARCHAR2(50) NOT NULL,
    CharacterDescription VARCHAR2(500),
    CharacterSize VARCHAR2(20) NOT NULL,
    Race VARCHAR2(50) NOT NULL,
    Alignment VARCHAR2(50) NOT NULL,
    CharacterClass VARCHAR2(50) NOT NULL,
    CharacterLevel NUMBER(2) NOT NULL,
    NPC NUMBER(1) NOT NULL,
    Armor_Class NUMBER(2) NOT NULL,
    Speed NUMBER(2) NOT NULL,
    Strength NUMBER(2) NOT NULL,
    Constitution NUMBER(2) NOT NULL,
    Dexterity NUMBER(2) NOT NULL,
    Wisdom NUMBER(2) NOT NULL,
    Intelligence NUMBER(2) NOT NULL,
    Charisma NUMBER(2) NOT NULL,
    CONSTRAINT CHARACTER_PK PRIMARY KEY (CharacterId),
    CONSTRAINT CHARACTER_OWNER_FK FOREIGN KEY (OwnerId) REFERENCES Players(PlayerId)
);

CREATE TABLE Campaigns (
    CampaignId NUMBER(9),
    CampaignDescription VARCHAR2(1000) NOT NULL,
    Setting VARCHAR2(1000) NOT NULL,
    RulesSystem VARCHAR2(50) NOT NULL,
    CONSTRAINT CAMPAIGN_PK PRIMARY KEY (CampaignId)
);

CREATE TABLE Quests (
    QuestId NUMBER(9),
    CampaignId NUMBER(9),
    Active NUMBER(1) NOT NULL,
    QuestDescription VARCHAR2(1000) NOT NULL,
    Chapter VARCHAR2(1000) NOT NULL,
    CONSTRAINT QUEST_PK PRIMARY KEY (QuestId),
    CONSTRAINT Q_CAMPAIGN_FK FOREIGN KEY (CampaignId) REFERENCES Campaigns(CampaignId)
);

CREATE TABLE Items (
    ItemId NUMBER(9),
    ItemName VARCHAR2(50) NOT NULL,
    ItemDescription VARCHAR2(1000),
    Material VARCHAR2(50) NOT NULL,
    Rarity VARCHAR2(50) NOT NULL,
    Magic NUMBER(1) NOT NULL,
    Cost NUMBER(9) NOT NULL,
    CONSTRAINT ITEM_PK PRIMARY KEY (ItemId)
);

CREATE TABLE ARMOR (
    ArmorId NUMBER(9),
    ArmorName VARCHAR2(50) NOT NULL,
    ArmorDescription VARCHAR2(1000),
    Material VARCHAR2(50) NOT NULL,
    ArmorWeight VARCHAR2(50) NOT NULL,
    Cost NUMBER(9) NOT NULL,
    Rarity VARCHAR2(50) NOT NULL,
    Magic NUMBER(1) NOT NULL,
    Armor_Class NUMBER(2) NOT NULL,
    Martial NUMBER(1) NOT NULL,
    CONSTRAINT ARMOR_PK PRIMARY KEY (ArmorId)
);

CREATE TABLE Weapons (
    WeaponId NUMBER(9),
    WeaponName VARCHAR2(50) NOT NULL,
    WeaponDescription VARCHAR2(1000),
    Damage VARCHAR2(50) NOT NULL,
    Magic NUMBER(1) NOT NULL,
    Cost NUMBER(9) NOT NULL,
    Rarity VARCHAR2(50) NOT NULL,
    WeaponWeight VARCHAR2(50) NOT NULL,
    Hands NUMBER(1) NOT NULL,
    Versatile NUMBER(1) NOT NULL,
    Material VARCHAR2(50) NOT NULL,
    Martial NUMBER(1) NOT NULL,
    CONSTRAINT WEAPON_PK PRIMARY KEY (WeaponId)
);

CREATE TABLE Abilities (
    AbilityId NUMBER(9),
    AbilityName VARCHAR2(50) NOT NULL,
    AbilityDescription VARCHAR2(1000) NOT NULL,
    Cost VARCHAR2(50) NOT NULL,
    Passive NUMBER(1) NOT NULL,
    CONSTRAINT ABILITY_PK PRIMARY KEY (AbilityId)
);

CREATE TABLE Spells (
    SpellId NUMBER(9),
    SpellName VARCHAR2(50) NOT NULL,
    SpellDescription VARCHAR2(1000) NOT NULL,
    Concentration NUMBER(1) NOT NULL,
    SpellRange VARCHAR2(50) NOT NULL,
    SpellLevel NUMBER(1) NOT NULL,
    Damage VARCHAR2(5),
    Duration VARCHAR2(50) NOT NULL,
    Cost VARCHAR2(50) NOT NULL,
    Constraint SPELL_PK PRIMARY KEY (SpellId)
);

CREATE TABLE Creature_Abilities (
    CreatureId NUMBER(9),
    AbilityId NUMBER(9),
    CONSTRAINT CREATURE_ABILITY_PK PRIMARY KEY (CreatureId, AbilityId),
    CONSTRAINT CRA_CREATURE_FK FOREIGN KEY (CreatureId) REFERENCES Creatures(CreatureId),
    CONSTRAINT CRA_ABILITY_FK FOREIGN KEY (AbilityId) REFERENCES Abilities(AbilityId)
);

CREATE TABLE Creature_Items (
    CreatureId NUMBER(9),
    ItemId NUMBER(9),
    ItemCount NUMBER(9) NOT NULL,
    CONSTRAINT CREATURE_ITEM_PK PRIMARY KEY (CreatureId, ItemId),
    CONSTRAINT CRI_CREATURE_FK FOREIGN KEY (CreatureId) REFERENCES Creatures(CreatureId),
    CONSTRAINT CRI_ITEM_FK FOREIGN KEY (ItemId) REFERENCES Items(ItemId)
);

CREATE TABLE Creature_Spells (
    CreatureId NUMBER(9),
    SpellId NUMBER(9),
    CONSTRAINT CREATURE_SPELL_PK PRIMARY KEY (CreatureId, SpellId),
    CONSTRAINT CRS_CREATURE_FK FOREIGN KEY (CreatureId) REFERENCES Creatures(CreatureId),
    CONSTRAINT CRS_SPELL_FK FOREIGN KEY (SpellId) REFERENCES Spells(SpellId)
);

CREATE TABLE Creature_Armor (
    CreatureId NUMBER(9),
    ArmorId NUMBER(9),
    ArmorCount NUMBER(9) NOT NULL,
    CONSTRAINT CREATURE_ARMOR_PK PRIMARY KEY (CreatureId, ArmorId),
    CONSTRAINT CRAR_CREATURE_FK FOREIGN KEY (CreatureId) REFERENCES Creatures(CreatureId),
    CONSTRAINT CRAR_ARMOR_FK FOREIGN KEY (ArmorId) REFERENCES Armor(ArmorId)
);

CREATE TABLE Creature_Weapons (
    CreatureId NUMBER(9),
    WeaponId NUMBER(9),
    WeaponCount NUMBER(9) NOT NULL,
    CONSTRAINT CREATURE_WEAPON_PK PRIMARY KEY (CreatureId, WeaponId),
    CONSTRAINT CRW_CREATURE_FK FOREIGN KEY (CreatureId) REFERENCES Creatures(CreatureId),
    CONSTRAINT CRW_WEAPON_FK FOREIGN KEY (WeaponId) REFERENCES Weapons(WeaponId)
);

CREATE TABLE Character_Abilities (
    CharacterId NUMBER(9),
    AbilityId NUMBER(9),
    CONSTRAINT CHARACTER_ABILITY_PK PRIMARY KEY (CharacterId, AbilityId),
    CONSTRAINT CHA_CHARACTER_FK FOREIGN KEY (CharacterId) REFERENCES Characters(CharacterId),
    CONSTRAINT CHA_ABILITY_FK FOREIGN KEY (AbilityId) REFERENCES Abilities(AbilityId)
);

CREATE TABLE Character_Items (
    CharacterId NUMBER(9),
    ItemId NUMBER(9),
    ItemCount NUMBER(9),
    CONSTRAINT CHARACTER_ITEM_PK PRIMARY KEY (CharacterId, ItemId),
    CONSTRAINT CHI_CHARACTER_FK FOREIGN KEY (CharacterId) REFERENCES Characters(CharacterId),
    CONSTRAINT CHI_ITEM_FK FOREIGN KEY (ItemId) REFERENCES Items(ItemId)
);

CREATE TABLE Character_Spells (
    CharacterId NUMBER(9),
    SpellId NUMBER(9),
    CONSTRAINT CHARACTER_SPELL_PK PRIMARY KEY (CharacterId, SpellId),
    CONSTRAINT CHS_CHARACTER_FK FOREIGN KEY (CharacterId) REFERENCES Characters(CharacterId),
    CONSTRAINT CHS_SPELL_FK FOREIGN KEY (SpellId) REFERENCES Spells(SpellId)
);

CREATE TABLE Character_Armor (
    CharacterId NUMBER(9),
    ArmorId NUMBER(9),
    ArmorCount NUMBER(9) NOT NULL,
    CONSTRAINT CHARACTER_ARMOR_PK PRIMARY KEY (CharacterId, ArmorId),
    CONSTRAINT CHAR_CHARACTER_FK FOREIGN KEY (CharacterId) REFERENCES Characters(CharacterId),
    CONSTRAINT CHAR_ARMOR_FK FOREIGN KEY (ArmorId) REFERENCES Armor(ArmorId)
);

CREATE TABLE Character_Weapons (
    CharacterId NUMBER(9),
    WeaponId NUMBER(9),
    WeaponCount NUMBER(9) NOT NULL,
    CONSTRAINT CHARACTER_WEAPONS_PK PRIMARY KEY (CharacterId, WeaponId),
    CONSTRAINT CHW_CHARACTER_FK FOREIGN KEY (CharacterId) REFERENCES Characters(CharacterId),
    CONSTRAINT CHW_WEAPON_FK FOREIGN KEY (WeaponId) REFERENCES Weapons(WeaponId)
);

CREATE TABLE Item_Abilities (
    ItemId NUMBER(9),
    AbilityId NUMBER(9),
    CONSTRAINT ITEM_ABILITY_PK PRIMARY KEY (ItemId, AbilityId),
    CONSTRAINT IA_ITEM_FK FOREIGN KEY (ItemId) REFERENCES Items(ItemId),
    CONSTRAINT IA_ABILITY_FK FOREIGN KEY (AbilityId) REFERENCES Abilities(AbilityId)
);

CREATE TABLE Armor_Abilities (
    ArmorId NUMBER(9),
    AbilityId NUMBER(9),
    CONSTRAINT ARMOR_ABILITY_PK PRIMARY KEY (ArmorId, AbilityId),
    CONSTRAINT AA_ARMOR_FK FOREIGN KEY (ArmorId) REFERENCES Armor(ArmorId),
    CONSTRAINT AA_ABILITY_FK FOREIGN KEY (AbilityId) REFERENCES Abilities(AbilityId)
);

CREATE TABLE Weapon_Abilities (
    WeaponId NUMBER(9),
    AbilityId NUMBER(9),
    CONSTRAINT WEAPON_ABILITY_PK PRIMARY KEY (WeaponId, AbilityId),
    CONSTRAINT WA_WEAPON_FK FOREIGN KEY (WeaponId) REFERENCES Weapons(WeaponId),
    CONSTRAINT WA_ABILITY_FK FOREIGN KEY (AbilityId) REFERENCES Abilities(AbilityId)
);

CREATE TABLE Campaign_Owners (
    CampaignId NUMBER(9),
    PlayerId NUMBER(9),
    CONSTRAINT CO_PK PRIMARY KEY (CampaignId, PlayerId),
    CONSTRAINT CO_CAMPAIGN_FK FOREIGN KEY (CampaignId) REFERENCES Campaigns(CampaignId),
    CONSTRAINT CO_PLAYER_FK FOREIGN KEY (PlayerId) REFERENCES Players(PlayerId)
);

CREATE TABLE Campaign_Characters (
    CampaignId NUMBER(9),
    CharacterId NUMBER(9),
    CONSTRAINT CC_PK PRIMARY KEY (CampaignId, CharacterId),
    CONSTRAINT CC_CAMPAIGN_FK FOREIGN KEY (CampaignId) REFERENCES Campaigns(CampaignId),
    CONSTRAINT CC_Character_FK FOREIGN KEY (CharacterId) REFERENCES Characters(CharacterId)
);