import os
import re
from pathlib import Path
import shutil

def process_repo_html_files(repo_path, output_folder="FNFMODHTML"):
    """
    Process HTML files from a repository and create modified versions.
    
    Args:
        repo_path: Path to the repository on your system
        output_folder: Name of the folder to save processed HTML files
    """
    
    # Get repository name from the path
    repo_name = os.path.basename(os.path.normpath(repo_path))
    
    # Create output directory if it doesn't exist
    output_path = os.path.join(os.path.dirname(repo_path), output_folder)
    os.makedirs(output_path, exist_ok=True)
    
    # Counter for processed files
    processed_count = 0
    error_count = 0
    
    print(f"Processing repository: {repo_name}")
    print(f"Repository path: {repo_path}")
    print(f"Output folder: {output_path}")
    print("-" * 50)
    
    # Walk through all directories in the repo
    for root, dirs, files in os.walk(repo_path):
        # Skip the output folder if it's inside the repo
        if output_folder in root:
            continue
            
        # Look for index.html files
        if "index.html" in files:
            # Get folder name (the immediate parent folder containing index.html)
            folder_name = os.path.basename(root)
            
            # Define input and output paths
            input_html_path = os.path.join(root, "index.html")
            output_filename = f"{folder_name}.html"
            output_html_path = os.path.join(output_path, output_filename)
            
            try:
                # Read the original HTML file
                with open(input_html_path, 'r', encoding='utf-8') as file:
                    html_content = file.read()
                
                # Create the base href line to insert
                base_href = f'<base href="https://cdn.jsdelivr.net/gh/waycrosspublicmedia/{repo_name}@main/{folder_name}/">\n'
                
                # Pattern to find the <head> tag and insert after it
                # Using regex with re.DOTALL to handle multi-line <head> tags
                pattern = r'(<head[^>]*>)'
                
                # Insert the base href after <head> tag
                # Using re.sub with a function to handle the replacement
                def insert_base_href(match):
                    return match.group(1) + '\n' + base_href
                
                modified_html = re.sub(pattern, insert_base_href, html_content, flags=re.IGNORECASE | re.DOTALL)
                
                # If no replacement was made (head tag might be malformed or missing),
                # insert at the beginning of the file
                if modified_html == html_content:
                    print(f"Warning: No <head> tag found in {input_html_path}")
                    print("Inserting base tag at the beginning of the file")
                    modified_html = base_href + html_content
                
                # Write the modified HTML to the output file
                with open(output_html_path, 'w', encoding='utf-8') as file:
                    file.write(modified_html)
                
                print(f"✓ Processed: {folder_name}")
                print(f"  Input: {input_html_path}")
                print(f"  Output: {output_filename}")
                processed_count += 1
                
            except Exception as e:
                print(f"✗ Error processing {folder_name}: {str(e)}")
                error_count += 1
    
    print("-" * 50)
    print(f"Processing complete!")
    print(f"Successfully processed: {processed_count} files")
    print(f"Errors: {error_count}")
    print(f"Output folder: {output_path}")
    
    # Create a summary file
    summary_path = os.path.join(output_path, "processing_summary.txt")
    with open(summary_path, 'w') as summary_file:
        summary_file.write(f"Repository: {repo_name}\n")
        summary_file.write(f"Processed files: {processed_count}\n")
        summary_file.write(f"Errors: {error_count}\n")
        summary_file.write("\nProcessed folders:\n")
        
        # List all processed files
        for root, dirs, files in os.walk(repo_path):
            if "index.html" in files and output_folder not in root:
                folder_name = os.path.basename(root)
                summary_file.write(f"- {folder_name}\n")
    
    print(f"Summary saved to: {summary_path}")

def main():
    """Main function to run the script."""
    print("=" * 50)
    print("FNF Mod HTML Processor")
    print("=" * 50)
    
    # Get repository path from user
    repo_path = input("Enter the path to your repository: ").strip()
    
    # Remove quotes if user drag-and-dropped a folder
    repo_path = repo_path.strip('"').strip("'")
    
    # Validate the path
    if not os.path.exists(repo_path):
        print(f"Error: The path '{repo_path}' does not exist.")
        return
    
    if not os.path.isdir(repo_path):
        print(f"Error: '{repo_path}' is not a directory.")
        return
    
    # Ask for custom output folder name
    output_folder = input("Enter output folder name (default: FNFMODHTML): ").strip()
    if not output_folder:
        output_folder = "FNFMODHTML"
    
    print("\nStarting processing...\n")
    
    # Process the repository
    process_repo_html_files(repo_path, output_folder)

if __name__ == "__main__":
    main()