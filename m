From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 15 Jun 2008 22:16:06 +0000
Subject: sh/boards/se/770x/io.c: suspicious code
Message-Id: <20080615221606.GA1407@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

sh_pcic_io_start and sh_pcic_io_stop are used as lower and upper limits 
for ports but never set to any non-zero value.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

