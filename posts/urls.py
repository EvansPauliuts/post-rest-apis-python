# from django.urls import path
from rest_framework.routers import SimpleRouter
from .views import (
    # PostList,
    # PostDetail,
    # UserList,
    # UserDetail,
    UserViewSet,
    PostViewSet,
)

# app_name = 'posts'
#
# urlpatterns = [
#     path('', PostList.as_view(), name='list'),
#     path('<int:pk>/', PostDetail.as_view(), name='detail'),
#     path('users/', UserList.as_view(), name='users'),
#     path('users/<int:pk>', UserDetail.as_view(), name='users-detail'),
# ]

router = SimpleRouter()
router.register('users', UserViewSet, basename='users')
router.register('', PostViewSet, basename='posts')

urlpatterns = router.urls
