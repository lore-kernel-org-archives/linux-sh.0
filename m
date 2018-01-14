From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 14 Jan 2018 17:47:42 +0000
Subject: [PATCH 0/2] sh_eth: simplify TSU initialization
Message-Id: <20180114174742.388057652@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello!

Here's a set of 2 patches against DaveM's 'net-next.git' repo. With those,
I'm somewhat simplifying the TSU init code in the driver probe() method...

[1/2] sh_eth: gather all TSU init code in one place
[2/2] sh_eth: get Ether port # only when needed

MBR, Sergei
