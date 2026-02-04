from rest_framework import viewsets, status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Item
from .serializers import ItemSerializer

@api_view(['GET'])
def api_root(request):
    """API root endpoint"""
    return Response({
        'message': 'Welcome to Django Starter API',
        'version': '1.0.0',
        'endpoints': {
            'items': '/api/items/',
            'admin': '/admin/',
        }
    })

class ItemViewSet(viewsets.ModelViewSet):
    """
    ViewSet for Item model
    Provides CRUD operations
    """
    queryset = Item.objects.all()
    serializer_class = ItemSerializer

    def get_queryset(self):
        """Filter active items by default"""
        queryset = super().get_queryset()
        active_only = self.request.query_params.get('active', None)
        if active_only == 'true':
            queryset = queryset.filter(is_active=True)
        return queryset
