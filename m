From: Luca Santini <luca.santini@spesonline.com>
Date: Sat, 22 Nov 2008 11:50:28 +0000
Subject: git pull breaks edosk7760 kernel
Message-Id: <4927F204.5090805@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,
yesterday i pulled from git and obtained an unbootable kernel.
My last working pull is dated

commit 882b689432129bfe77530d61f70797147179a742
Merge: b86c2c0... fb059cd...
Author: Luca Santini <santox@libero.it>
Date:   Thu Nov 13 11:31:54 2008 +0100


The only thing i was able to do is 
git reset --hard HEAD^ 

i'm not a god of git... is there a way to "pull step by step" and find the offending patch(es)? 
