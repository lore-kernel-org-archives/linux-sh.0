From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 29 Sep 2015 12:52:39 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: link PCI USB devices to USB PHY
Message-Id: <560A8997.8090301@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <10927620.1TFu7PRvi4@wasted.cogentembedded.com>
 <20150929003751.GB20067@verge.net.au>
In-Reply-To: <20150929003751.GB20067@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 9/29/2015 3:37 AM, Simon Horman wrote:

>> Describe the PCI USB devices that are behind the PCI bridges, adding necessary
>> links to the USB PHY device.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against 'renesas-devel-20150911v2-v4.2' tag of Simon Horman's
>> 'renesas.git' repo plus the R8A7794/SILK PCI USB and USB PHY support patches
>> just posted.

> Does this series have any dependencies (e.g. bindings) other

    This patch, you mean?

> than the aforementioned R8A7794/SILK PCI USB and USB PHY support patches?

    No.

MBR, Sergei

