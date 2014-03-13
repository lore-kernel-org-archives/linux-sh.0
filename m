From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 13 Mar 2014 11:43:36 +0000
Subject: Re: [PATCH] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <532199E8.1050109@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 13/03/14 11:37, Geert Uytterhoeven wrote:
> Hi Ben,
>
> On Thu, Mar 13, 2014 at 12:35 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>> Yes, now it disables the hardware clock bits for all clocks that are not
>>> in
>>> use according to CCF:
>>
>> Do you have the drivers/sh fix in?
>
> No, I removed that due to bad interaction with userspace:
>
> Unhandled fault: imprecise external abort (0x1406) at 0x00000000

Hmm, so if you disable clocks that peripherals need then there's no
surprise that the system fails to boot :/ I added an patch to stop
the abort being fatal to allow continued boot.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
