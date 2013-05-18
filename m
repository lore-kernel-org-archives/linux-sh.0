From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 18 May 2013 15:28:56 +0000
Subject: Re: [PATCH 4/9] ARM: shmobile: r8a7790: add clock definitions and aliases for MMCIF and SDHI
Message-Id: <51979E38.1000802@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 18-05-2013 19:02, Guennadi Liakhovetski wrote:

>>> Add MSTP clock definitions and fix aliases for the two MMCIF and four SDHI
>>> interfaces on r8a7790 (H2).

>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>>> ---
>>>    arch/arm/mach-shmobile/clock-r8a7790.c |   26 +++++++++++++++++++-------
>>>    1 files changed, 19 insertions(+), 7 deletions(-)

>>> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c
>>> b/arch/arm/mach-shmobile/clock-r8a7790.c
>>> index b393592..53a13b4 100644
>>> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
>>> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
>>> @@ -181,7 +181,7 @@ static struct clk div6_clks[DIV6_NR] = {
>>>    /* MSTP */
>>>    enum {
>>>    	MSTP721, MSTP720,
>>> -	MSTP304,
>>> +	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311,

>>     Should have broken this line here.

> Don't think so.

    At least breaking the lines at numerical tens of MSTPxxx values was 
a tradition so far (although ten values don't fit in one line :-).

>>> MSTP305, MSTP304,

WBR, Sergei

