From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 02 Oct 2015 21:43:08 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: link PCI USB devices to USB PHY
Message-Id: <560EFA6C.4090404@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <10927620.1TFu7PRvi4@wasted.cogentembedded.com>
 <20150929003751.GB20067@verge.net.au> <560A8997.8090301@cogentembedded.com>
 <20151002020021.GF22640@verge.net.au>
In-Reply-To: <20151002020021.GF22640@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 10/02/2015 05:00 AM, Simon Horman wrote:

>>>> Describe the PCI USB devices that are behind the PCI bridges, adding necessary
>>>> links to the USB PHY device.
>>>>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>>
>>>> ---
>>>> This patch is against 'renesas-devel-20150911v2-v4.2' tag of Simon Horman's
>>>> 'renesas.git' repo plus the R8A7794/SILK PCI USB and USB PHY support patches
>>>> just posted.
>>
>>> Does this series have any dependencies (e.g. bindings) other
>>
>>     This patch, you mean?
>>
>>> than the aforementioned R8A7794/SILK PCI USB and USB PHY support patches?

> Thanks, I have queued this up for v4.4.

    Thank you!

> I think I have got everything now but please let me know if you have any
> shmobile DT patches outstanding which are ready to be queued-up.

    Yes, the R8A7794 HS-USB patch.

MBR, Sergei

