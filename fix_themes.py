import os
import glob
import re

lib_dir = '/Users/hamada/Developer/flutter_projects/book/lib'
files_to_check = glob.glob(f'{lib_dir}/presentation/widgets/**/*.dart', recursive=True)

for file in files_to_check:
    with open(file, 'r') as f:
        content = f.read()
    
    # Check if the file contains AppColors.text
    if 'AppColors.text' in content:
        # Add import if not present
        if 'import \'package:book/core/theme/app_colors.dart\';' not in content and 'import "../../../core/theme/app_colors.dart";' not in content:
            # Usually the import is there if AppColors is used
            pass
            
        new_content = re.sub(r'AppColors\.text(Primary|Secondary|Tertiary)', r'context.adaptiveText\1', content)
        
        # Also replace AppTextStyles properties with method calls
        new_content = re.sub(r'AppTextStyles\.heroAccent\.copyWith', r'AppTextStyles.heroAccent(context).copyWith', new_content)
        new_content = re.sub(r'AppTextStyles\.h3\.copyWith', r'AppTextStyles.h3(context).copyWith', new_content)
        new_content = re.sub(r'AppTextStyles\.bodyLarge\.copyWith', r'AppTextStyles.bodyLarge(context).copyWith', new_content)

        if new_content != content:
            with open(file, 'w') as f:
                f.write(new_content)
            print(f"Updated {file}")

