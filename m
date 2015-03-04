From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Wed, 04 Mar 2015 04:46:05 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: Add r8a7794 reset code for SMP
Message-Id: <54F68E0D.2090709@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <54F50C76.2060803@bp.renesas.com>
In-Reply-To: <54F50C76.2060803@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon-san,

Thank you for your feedback.

On 2015/03/04 10:36, Simon Horman wrote:

> Hi Inami-san,
>
> On Tue, Mar 03, 2015 at 10:20:54AM +0900, Gaku Inami wrote:
>> Since reset vector settings is controlled by SYSC
>> register, this code is added to pm-r8a7794.c.
> As both this and the previous patch, which appears to create a stub
> pm-r8a7794.c, are quite small I think it would make sense to squash these
> two patches into one.

I will fix it with V2 patch.

Regards,
Inami

