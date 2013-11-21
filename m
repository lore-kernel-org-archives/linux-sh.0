From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 21 Nov 2013 10:38:12 +0000
Subject: Re: [PATCH 7/9] ARM: shmobile: r8a7790: add internal PCI clock
Message-Id: <CAO3366y9n6ax-a1fhTAdmg4DmxdH_MzQpa+bvecRh65-y0kCQw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384969086-8920-8-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1384969086-8920-8-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 20, 2013 at 10:18 PM, Valentine
<valentine.barshak@cogentembedded.com> wrote:
> On 11/20/2013 09:38 PM, Ulrich Hecht wrote:
>> +       [MSTP703] = SH_CLK_MSTP32(&mp_clk, SMSTPCR7, 3, 0), /* EHCI */
>
> The comment to the above line is a bit misleading.

The comments reflect the labels given to the bits in the
documentation. The documentation labels this bit "EHCI".

>> +       CLKDEV_ICK_ID("usbpci", "pci-rcar-gen2.1", &mstp_clks[MSTP703]),
>> +       CLKDEV_ICK_ID("usbpci", "pci-rcar-gen2.2", &mstp_clks[MSTP703]),
>
>
> The CLKDEV_DEV_ID should be used instead for both pci clocks.

Will fix that.

CU
Uli
