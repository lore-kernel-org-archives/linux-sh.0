From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 16 Mar 2010 11:25:42 +0000
Subject: Hi All, hot to debug my eth0' hw?
Message-Id: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all, I build a board with smsc 9118 eth chip; Of course I'm not sure the hw 
is ok.
I'm think to boot with nfs root with no success with these messages:
TCP bic registered
eth0: --> smc911x_open
eth0: --> smc911x_reset
eth0: --> smc911x_phy_configure()
eth0: --> smc911x_phy_reset()
eth0: phy caps=0x7809
eth0: phy advertised caps=0x0de1
eth0: --> smc911x_phy_check_media
smc911x_phy_read: phyaddr=0x1, phyreg=0x01, phydata=0x7809
smc911x_phy_read: phyaddr=0x1, phyreg=0x01, phydata=0x7809
eth0: link down
eth0: --> smc911x_enable
eth0: --> smc911x_set_multicast_list
eth0: ~(MAC_CR_PRMS_|MAC_CR_MCPAS_)
eth0: update mcast hash table 0x00000000 0x00000000
eth0: --> smc911x_query_statistics
eth0: --> smc911x_set_multicast_list
eth0: ~(MAC_CR_PRMS_|MAC_CR_MCPAS_)
eth0: update mcast hash table 0x00000000 0x00000000
eth0: --> smc911x_query_statistics
eth0: --> smc911x_query_statistics
eth0: --> smc911x_set_multicast_list
eth0: update mcast hash table 0x00000000 0x80000000
IP-Config: Complete:
      device=eth0, addr2.168.1.3, mask%5.255.255.0, gw2.168.1.254,
     host=uclinux, domain=, nis-domain=(none),
     bootserver2.168.1.2, rootserver2.168.1.2, rootpathLooking up port of RPC 100003/2 on 192.168.1.2
portmap: server 192.168.1.2 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.1.2
portmap: server 192.168.1.2 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 192.168.1.2 not responding, timed out
Root-NFS: Server returned error -5 while mounting /home/fgiovagnini/nfsroot
VFS: Unable to mount root fs via NFS, trying floppy.
mount_block_root,294 - debug 1
mount_block_root,298 - debug 2
do_mount_root,270 - debug 1
/dev/root,0x0cc9b000,0x00008000,0x00000000
do_mount_root,273 - debug 2
mount_block_root,300 - debug 3
No filesystem could mount root, tried:  nfs
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)

tring to ping as no effect.
I'm sure the IPR register is properly set.
How can I debug my proble?
Could you sugget me a robust and fast way?

Thanks in advance

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
