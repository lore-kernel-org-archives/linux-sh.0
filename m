From: Luca Santini <luca.santini@spesonline.com>
Date: Tue, 22 Jul 2008 14:17:40 +0000
Subject: problems opening console
Message-Id: <4885EC04.4060708@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

I almost done the porting of kernel2.6.26 to the edosk7760 board,
(adding the board-specific machvec copying functions from kernel2.4)
but i have problem on init console; these are last log lines of kernel boot:


[    0.000000] Kernel command line: memdM sh_mv=EDOSK7760=20
console=3DttySC2,115200 rw sh_pclk3335000 root=3D/dev/ram

....

[    2.721824] RAMDISK: Compressed image found at block 0
[    5.011947] kjournald starting.  Commit interval 5 seconds
[    5.012189] EXT3 FS on ram0, internal journal
[    5.016100] EXT3-fs: mounted filesystem with ordered data mode.
[    5.022155] VFS: Mounted root (ext3 filesystem).
[    5.027005] Freeing unused kernel memory: 116k freed


after a few debugging i discovered that the kernel hangs trying to open=20
/dev/console
(in init/main.c ;  init_post(void) function)

the rootfs seems correctly mounted and the devices /dev/console and=20
/dev/ttySC2 are present in the filesystem.

anybody can help me?
