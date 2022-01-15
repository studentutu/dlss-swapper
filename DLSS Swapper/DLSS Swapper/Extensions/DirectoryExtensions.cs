using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DLSS_Swapper.Extensions
{
    internal static class DirectoryExtensions
    {
        // I don't get why BetterFileList is 10x faster.
        // Original source: https://stackoverflow.com/a/2114512
        public static IEnumerable<string> BetterGetFiles(string rootFolderPath, string fileSearchPattern)
        {
            return BetterGetFiles(new DirectoryInfo(rootFolderPath), fileSearchPattern, 1).Select(x => x.FullName);
        }

        internal static IEnumerable<FileInfo> BetterGetFiles(DirectoryInfo directory, string fileSearchPattern, int depth)
        {
            return depth == 0
                ? directory.GetFiles(fileSearchPattern, SearchOption.TopDirectoryOnly)
                : directory.GetFiles(fileSearchPattern, SearchOption.TopDirectoryOnly).Concat(
                    directory.GetDirectories().SelectMany(x => BetterGetFiles(x, fileSearchPattern, depth - 1)));
        }
    }
}
