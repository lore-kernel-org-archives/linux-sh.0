From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Mar 2011 02:59:14 +0000
Subject: [PATCH v6] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
Message-Id: <1301453955-15759-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Magnus,

could I get an Ack or otherwise from you on this change?
All the pre-requisites are in 2.6.39-rc1.

Note that if you are inclined to build a 2.6.39-rc1 kernel for mackerel you
will also need "sh: intc: fix build error in interrupts.h"
(https://patchwork.kernel.org/patch/672972/) or similar.  That change is
unrelated to my work.

