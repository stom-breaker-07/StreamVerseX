import random


# -----------------------------
# Device Types
# -----------------------------
DEVICE_TYPES = [
    "Mobile",
    "Desktop",
    "TV",
    "Tablet"
]

DEVICE_WEIGHTS = [
    55,
    15,
    20,
    10
]


def get_device():
    return random.choices(
        DEVICE_TYPES,
        weights=DEVICE_WEIGHTS,
        k=1
    )[0]


# -----------------------------
# Stream Quality
# -----------------------------
STREAM_QUALITY = [
    "480p",
    "720p",
    "1080p",
    "4K"
]

QUALITY_WEIGHTS = [
    15,
    25,
    40,
    20
]


def get_quality():
    return random.choices(
        STREAM_QUALITY,
        weights=QUALITY_WEIGHTS,
        k=1
    )[0]


# -----------------------------
# Session Status
# -----------------------------
SESSION_STATUS = [
    "Completed",
    "Paused",
    "Dropped"
]

STATUS_WEIGHTS = [
    70,
    20,
    10
]


def get_session_status():
    return random.choices(
        SESSION_STATUS,
        weights=STATUS_WEIGHTS,
        k=1
    )[0]


# -----------------------------
# Search Queries
# -----------------------------
SEARCH_QUERIES = [

    "Marvel",

    "Action",

    "Comedy",

    "Anime",

    "IPL",

    "Football",

    "Sci-Fi",

    "Thriller",

    "KDrama",

    "Horror"

]


def get_search_query():
    return random.choice(
        SEARCH_QUERIES
    )


# -----------------------------
# Screens
# -----------------------------
SCREENS = [

    "Home",

    "Search",

    "Details",

    "Player",

    "Downloads",

    "Profile"

]


def get_screen():
    return random.choice(
        SCREENS
    )


# -----------------------------
# Click Actions
# -----------------------------
CLICK_ACTIONS = [

    "Click",

    "Scroll",

    "Play",

    "Pause",

    "Resume"

]


def get_click_action():
    return random.choice(
        CLICK_ACTIONS
    )


# -----------------------------
# Regions
# -----------------------------
REGIONS = [

    "India",

    "USA",

    "UK",

    "Canada",

    "Australia"

]


def get_region():
    return random.choice(
        REGIONS
    )


# -----------------------------
# CDN Regions
# -----------------------------
SERVER_REGIONS = [

    "Mumbai",

    "Delhi",

    "Singapore",

    "London",

    "Virginia",
    
    "Berlin",
    
    "Tokyo",
    
    "Sydney",
    
    "Mascow",
    
    "Toronto"

]


def get_server_region():
    return random.choice(
        SERVER_REGIONS
    )


# -----------------------------
# Subscription Plans
# -----------------------------
PLANS = [

    "Basic",

    "Premium",

    "Family",

    "Sports"

]


def get_plan():
    return random.choice(
        PLANS
    )


# -----------------------------
# Payment Modes
# -----------------------------
PAYMENT_MODES = [

    "UPI",

    "Card",

    "NetBanking",

    "Wallet"

]


def get_payment_mode():
    return random.choice(
        PAYMENT_MODES
    )


# -----------------------------
# Payment Status
# -----------------------------
PAYMENT_STATUS = [

    "Success",

    "Failed",

    "Pending"

]

PAYMENT_WEIGHTS = [

    90,

    5,

    5

]


def get_payment_status():
    return random.choices(
        PAYMENT_STATUS,
        weights=PAYMENT_WEIGHTS,
        k=1
    )[0]


# -----------------------------
# Renewal Status
# -----------------------------
RENEWAL_STATUS = [

    "Active",

    "Cancelled",

    "Expired"

]


def get_renewal_status():
    return random.choice(
        RENEWAL_STATUS
    )


# -----------------------------
# Failure Codes
# -----------------------------
FAILURE_CODES = [

    0,

    100,

    101,

    200,

    404,

    500

]


def get_failure_code():
    return random.choice(
        FAILURE_CODES
    )