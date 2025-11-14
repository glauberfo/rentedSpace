#!/usr/bin/env python3
"""
Script para gerar ícones do app a partir do SVG
Requer: pip install cairosvg pillow
"""

import os
import sys
from pathlib import Path

try:
    import cairosvg
    from PIL import Image
except ImportError:
    print("Erro: Bibliotecas necessárias não encontradas.")
    print("Instale com: pip install cairosvg pillow")
    sys.exit(1)

# Tamanhos necessários para iOS
SIZES = {
    "Icon-App-20x20@1x.png": 20,
    "Icon-App-20x20@2x.png": 40,
    "Icon-App-20x20@3x.png": 60,
    "Icon-App-29x29@1x.png": 29,
    "Icon-App-29x29@2x.png": 58,
    "Icon-App-29x29@3x.png": 87,
    "Icon-App-40x40@1x.png": 40,
    "Icon-App-40x40@2x.png": 80,
    "Icon-App-40x40@3x.png": 120,
    "Icon-App-60x60@2x.png": 120,
    "Icon-App-60x60@3x.png": 180,
    "Icon-App-76x76@1x.png": 76,
    "Icon-App-76x76@2x.png": 152,
    "Icon-App-83.5x83.5@2x.png": 167,
    "Icon-App-1024x1024@1x.png": 1024,
}

def generate_icons(svg_path, output_dir):
    """Gera todos os ícones PNG a partir do SVG"""
    svg_path = Path(svg_path)
    output_dir = Path(output_dir)
    
    if not svg_path.exists():
        print(f"Erro: Arquivo SVG não encontrado: {svg_path}")
        return False
    
    output_dir.mkdir(parents=True, exist_ok=True)
    
    print(f"Gerando ícones a partir de: {svg_path}")
    print(f"Salvando em: {output_dir}\n")
    
    for filename, size in SIZES.items():
        output_path = output_dir / filename
        try:
            # Converter SVG para PNG
            png_data = cairosvg.svg2png(
                url=str(svg_path),
                output_width=size,
                output_height=size
            )
            
            # Abrir a imagem PNG
            from io import BytesIO
            img = Image.open(BytesIO(png_data))
            
            # Criar uma nova imagem com fundo branco
            white_bg = Image.new('RGB', (size, size), color='white')
            
            # Se a imagem tem transparência, fazer composição
            if img.mode == 'RGBA':
                white_bg.paste(img, (0, 0), img.split()[3])  # Usar canal alpha
            else:
                white_bg.paste(img, (0, 0))
            
            # Salvar PNG com fundo branco
            white_bg.save(output_path, 'PNG')
            
            print(f"✓ Gerado: {filename} ({size}x{size}) com fundo branco")
        except Exception as e:
            print(f"✗ Erro ao gerar {filename}: {e}")
            return False
    
    print("\n✅ Todos os ícones foram gerados com sucesso!")
    return True

if __name__ == "__main__":
    # Caminhos
    project_root = Path(__file__).parent.parent
    svg_path = project_root / "lib" / "assets" / "company_logo.svg"
    output_dir = project_root / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
    
    if generate_icons(svg_path, output_dir):
        print("\n📱 Próximos passos:")
        print("1. Abra o Xcode")
        print("2. Vá em Runner > Assets.xcassets > AppIcon")
        print("3. Arraste os ícones gerados para os slots correspondentes")
        print("4. Ou simplesmente substitua os arquivos PNG existentes")
    else:
        print("\n❌ Falha ao gerar ícones. Verifique os erros acima.")

