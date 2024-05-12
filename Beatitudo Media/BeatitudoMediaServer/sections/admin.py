from django.contrib import admin

# Register your models here.
from .models import Section
admin.site.register(Section)

from .models import Article
admin.site.register(Article)

from .models import Article_Metadata
admin.site.register(Article_Metadata)

from .models import Article_Auxiliary_Data
admin.site.register(Article_Auxiliary_Data)