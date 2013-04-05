From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 05 Apr 2013 15:47:35 +0000
Subject: Re: [PATCH 1/8] ARM: shmobile:Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
Message-Id: <515EF217.2010109@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304050257.00799.sergei.shtylyov@cogentembedded.com>
 <20130405004147.GN29203@verge.net.au>
In-Reply-To: <20130405004147.GN29203@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 05-04-2013 4:41, Simon Horman wrote:

>> USB EHCI, OHCI, and common PHY are the SoC devices but are wrongly defined and
>> registered in the Marzen board file.  Move the data and code to their proper
>> place in setup-r8a7779.c; while at it, we have to rename 8a7779_late_devices[]
>> to 8a7779_standard_devices[] -- this seems legitimate since they are registered
>> from r8a7779_add_standard_devices() anyway.

>> Note that I'm deliberately changing the USB PHY platform device's 'id' field
>> from (previously just omitted) 0 to -1 as the device is a single of its kind.

> Would it be possible to re-arange this patch so that
> there is an SoC patch followed by a board patch?

    I seriously doubt it, thought I'll try to think about it more. The patch 
adding the SoC devices to the board file should't have been accepted in the 
first place, so we wouldn't have to fix it eventually.

WBR, Sergei

