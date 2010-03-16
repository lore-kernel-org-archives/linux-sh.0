From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Mar 2010 12:41:28 +0000
Subject: Re: Trouble with embedding initial root fs into the kernel
Message-Id: <aec7e5c31003160541j6d41cfdeu18c9abd1bdcb1731@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

> In data marted=EC 16 marzo 2010 13:29:25, Magnus Damm ha scritto:
>> What hardware platform is this? rsk7203?

On Tue, Mar 16, 2010 at 9:35 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> It si my own, derived form rsk+7203
> its name in MLCD, and at the and I'll can send the BSP to linux-sh list, =
if
> you like

Ok, I think we may be interested in processor specific fixes to begin
with. But you need to update your BSP kernel to latest upstream before
we can use any of your work.

So please work with the latest kernel if possible. It is almost
impossible to fix bugs in an old kernel, and very few people will give
you support unless you pay them.

Thanks!

/ magnus
