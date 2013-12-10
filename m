From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 10 Dec 2013 17:15:24 +0000
Subject: Re: [PATCH] ARM: rcar-gen2: Do not setup timer in non-secure mode
Message-Id: <52A74C2C.9020805@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1386690813-15070-1-git-send-email-ben.dooks@codethink.co.uk>
 <52A748DE.8000508@cogentembedded.com>
In-Reply-To: <52A748DE.8000508@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/12/13 17:01, Sergei Shtylyov wrote:
> Hello.
>
> On 10-12-2013 19:53, Ben Dooks wrote:
>
>> If the system has been started in non-secure mode, then the ARM generic
>> timer is not configurable during the kernel initialisation. Currently
>> the only thing we can check for is if the timer has been correctly
>> configured during the boot process.
>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>


>   * bla
>   * bla
>   */
>
> WBR, Sergei

Thanks, fixed.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
