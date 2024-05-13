from .models import *

def fill_up_database_for_today():

    # Create the wrapper for sections
    wrapper = Sections.objects.create()

    # Create Sections that go into the wrapper
    