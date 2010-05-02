From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Sun, 02 May 2010 09:10:21 +0000
Subject: Discussion about register definition header
Message-Id: <201005021110.22111.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,
I'm not what you can sey a guru of linux embedded, but I have more than 10 
years of experience on embedded application without general porpouse operating 
system expecially (but not only) in the automotive environment.
I think that into include/asm dir shoud be a file containing ALL the mpu 
registers address definitions, for avoiding to have same definitions across 
different files and an high probability to write something wrong each time.
I think this has not already done beacuse it is a long work for testing. Is it 
the main reason?

All discussion is veri appreciated.

Regards
-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
