From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 09 Jan 2014 11:45:04 +0000
Subject: lager - non-booting latest horms' devel branch
Message-Id: <52CE8BC0.7060306@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am using the devel branch from Simon Horms' git tree, SHA1 
3da593ea7d797d9f59bd6ed1ee629fab681d7a23 and not seeing a
boot when using the multi arch defconfig and device-tree.

The board does not produce any console output so I am not
sure what is going on. Has anyone else had issues with using
the fdt-only boot?

The arch setup is:

CONFIG_ARCH_SHMOBILE=y
CONFIG_ARCH_SHMOBILE_MULTI=y
CONFIG_MACH_LAGER=y

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
