From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 21 Jun 2011 07:10:44 +0000
Subject: Re: [PATCH] PM / Runtime: Handle clocks correctly if
Message-Id: <BANLkTin0dq07rquuAmE-jE1nmkRnKH7aSA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201106210128.52101.rjw@sisk.pl>
In-Reply-To: <201106210128.52101.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@ti.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org

On Tue, Jun 21, 2011 at 8:28 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Commit 85eb8c8d0b0900c073b0e6f89979ac9c439ade1a (PM / Runtime:
> Generic clock manipulation rountines for runtime PM (v6)) converted
> the shmobile platform to using generic code for runtime PM clock
> management, but it changed the behavior for CONFIG_PM_RUNTIME unset
> incorrectly.
>
> Specifically, for CONFIG_PM_RUNTIME unset pm_runtime_clk_notify()
> should enable clocks for action equal to BUS_NOTIFY_BIND_DRIVER and
> it should disable them for action equal to BUS_NOTIFY_UNBOUND_DRIVER
> (instead of BUS_NOTIFY_ADD_DEVICE and BUS_NOTIFY_DEL_DEVICE,
> respectively). =A0Make this function behave as appropriate.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks Rafael!

Acked-by: Magnus Damm <damm@opensource.se>
