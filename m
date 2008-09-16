From: "Tiago Maluta" <tiago.maluta@gmail.com>
Date: Tue, 16 Sep 2008 13:27:29 +0000
Subject: initramfs problems
Message-Id: <600adaf50809160627p8ed94c5y5e4502042c617808@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I'm with problems to attach an iniramfs to vmlinux. I'm using:
linux-2.6.17.14_stm22_0038

From Documentation/filesystem/ramfs-romfs-initramfs.txt I got that I
can start initramfs by three ways

a) gzipped cpio archive
b) directory containing a filesystem
c) textfile

My first approach was using option b)

I read Documentation/early-userspace/README and populated a simple fs.
Basically, for my first test, I used the filesystem that already use
on MTD block.

I settled the folder CONFIG_INITRAMFS_SOURCE using menuconfig General
Setup --> () Initramfs source file(s)

But I got kernel panic:

VFS: Cannot open root device "<NULL>" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)


After I tryed option c) setting CONFIG_INITRAMFS_SOURCE with a
fileneme containing:

dir /dev 755 0 0
nod /dev/console 644 0 0 c 5 1
nod /dev/loop0 644 0 0 b 7 0
dir /bin 755 1000 1000
slink /bin/sh busybox 777 0 0
file /bin/busybox initramfs/busybox 755 0 0
dir /proc 755 0 0
dir /sys 755 0 0
dir /mnt 755 0 0
file /init initramfs/init.sh 755 0 0

But I dind't know exactly how this option work (I made just for free
my consciousness certainly that doesn't work)

I think the problem could be at GDB parameter. I'm using:

st40load_gdb \
        -t $JEI_IP \
        -b $KERNEL \
        -c $BOARD \
        console=ttyAS1,115200 \
        root=/dev/nfs rw \
        $ETHERNET \
        $IDE \
        $MTD \
        nfsroot=$SERVERIP:$SERVERDIR,$TCP_UDP \
        ip=$TARGETIP::$GWIP:$NETMASK:$NAME::$AUTOCONF \
        mem6m \
        bigphysarea12

I also tried but init option (but I think with initramfs I could not
be necessary).

Best regards,
Tiago Maluta
