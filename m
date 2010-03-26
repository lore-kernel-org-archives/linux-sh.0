From: Conrad Parker <conrad@metadecks.org>
Date: Fri, 26 Mar 2010 03:42:57 +0000
Subject: Re: [PATCH] sh: Update ecovec_defconfig
Message-Id: <dba6c0831003252042j297d6f86s2cb5a6b8165014f6@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4BA9CAF7.1040200@renesas.com>
In-Reply-To: <4BA9CAF7.1040200@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2010/3/24 Yusuke Goda <goda.yusuke@renesas.com>:
> =A0CONFIG_SYSFS_DEPRECATED=3Dy

perhaps we should set this to n to work with newer udev, eg. with the
current binaries from debian-sh (ie. if a user takes the existing
Ecovec BSP and does an apt-get upgrade, which is required in order to
install things like gstreamer).

Conrad.
