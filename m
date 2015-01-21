From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 21 Jan 2015 22:16:54 +0000
Subject: [PATCH 0/2] sh_eth: massage PM code
Message-Id: <5608250.lrFkJTjgSf@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's a set of 2 patches against DaveM's 'net-next.git' repo. We're adding
the support for suspend/hibernation as well as somewhat changing the existing
code. There are still MDIO-related issue with suspend (kernel exception), we've
been working on it and shall address it with a separate patch...

[1/2] sh_eth: use SET_RUNTIME_PM_OPS()
[2/2] sh_eth: add more PM methods

WBR, Sergei

