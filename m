From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 17 Mar 2010 16:28:25 +0000
Subject: nfsroot is to slow
Message-Id: <201003171728.25305.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,
now I'm able to mount root nfs but it is so slow:
/dev/root,0x0c1a58a0,0x00008000,0x0c24659c
do_mount_root,273 - debug 2
do_mount_root,277 - debug 3
do_mount_root,279 - debug 4
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 88k freed
nfs: server 192.168.1.2 not responding, still trying
nfs: server 192.168.1.2 OK
nfs: server 192.168.1.2 not responding, still trying
nfs: server 192.168.1.2 not responding, still trying

I can see this.
Where can I investigate.
Server side or my board side?

Thanks a lot

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
