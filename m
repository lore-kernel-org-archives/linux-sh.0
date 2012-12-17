From: Bastian Hecht <hechtb@gmail.com>
Date: Mon, 17 Dec 2012 11:23:44 +0000
Subject: Re: [PATCH 0/2] Preliminary Armadillo DT support
Message-Id: <CABYn4sybTknkc5aY12DF=SzpPbRoyc2Jty6_UG2VXr7QgObsyQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1355666066-25649-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1355666066-25649-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

>
> Preliminary Armadillo800eva DT support itself is very good.
> But I guess these patches kill off "current" Armadillo800eva users who are using many devices ?
>
> How about this ?
>   1) add new file like board-armadillo800eva-dt.c for DT support
>   2) keep adding new DT suuport on board-armadillo800eva-dt.c
>   3) If board-armadillo800eva-dt.c has full-support,
>      remove old board-armadillo800eva.c
>

Sounds like a plan!
Yes this looks like the way Simon has made up his kzm9g reference
implementation. So I suppose we want this extra board file in the
mainline until 3) happens?

Cheers,

 Bastian
