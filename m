From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 07 Jul 2020 15:11:22 +0000
Subject: Re: [PATCH v6 08/12] device core: Introduce DMA range map, supplanting dma_pfn_offset
Message-Id: <20200707151122.GX2571@kadam>
List-Id: <linux-sh.vger.kernel.org>
References: <20200701212155.37830-9-james.quinlan@broadcom.com>
 <20200707132724.GT2549@kadam>
 <CA+-6iNwzQ0gn2KfdqNGwGjDgPT5op8bTCs6paMT7BwVmm+9vTw@mail.gmail.com>
In-Reply-To: <CA+-6iNwzQ0gn2KfdqNGwGjDgPT5op8bTCs6paMT7BwVmm+9vTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: kbuild@lists.01.org, "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, lkp@intel.com, kbuild-all@lists.01.org, Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>, Hanjun Guo <guohanjun@huawei.com>, "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM" <linux-remoteproc@vger.kernel.org>

Sorry for the noise.  Your code is correct.  I'm not 100% sure what went
wrong.  Either the cross function database wasn't built or there is a
bug in the published code that is fixed on my private Smatch build.  I
will investigate.

regards,
dan carpenter
