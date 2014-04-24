# This file is part of the Arch-Installer

if [ $(id -u) -ne 0 ]
then
    echo ""
    echo "Root needed. Please call this script as root only." 1>&2
    exit 1
fi


echo ""
echo "###############################################################################"
echo "This script directly modifies the system and any partitions. It is highly"
echo "recommended you consult the fucking man pages (e.g. RTFM) before continuing."
echo ""
echo "In case anything goes wrong, you and only you are responsible for the loss"
echo "of partitioning data or any other substantial losses incurred from running it."
echo ""
echo "But ultimately this entire operation is up to you. That's why it's not called by"
echo "the main function after partitioning."
echo ""
echo "Only you are responsible for any changes made after this, so do not run unless"
echo "yu absolutely have read and trust the source code."

echo ""
echo -n "I accept these terms. [y|n]: "
read INPUT
if [ ! "${INPUT}" == "y" ] &&
then
    echo "Thanks for shopping with LUKS"
    exit 0
fi