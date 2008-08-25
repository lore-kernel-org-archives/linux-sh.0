From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 25 Aug 2008 13:42:17 +0000
Subject: Re: [PATCH] sh: ap325rxa: create CPLD data area in mtd
Message-Id: <20080825224217.10ba52b9.iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48B24FF8.6060009@renesas.com>
In-Reply-To: <48B24FF8.6060009@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Opps, 
This is a mistake. Please disregard it. 

Best regards,
 Nobuhiro

On Mon, 25 Aug 2008 15:31:56 +0900
Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com> wrote:

> AP320 and AP325RXA has CPLD data in NOR Flash.
> If this area erased, this board can not boot.
> This patch create CPLD data area and set writeable mask bit.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
-- 
Nobuhiro Iwamatsu
