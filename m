From: Shane McDonald <mcdonald.shane@gmail.com>
Date: Mon, 30 Jan 2012 14:19:31 +0000
Subject: Re: [PATCH 1/3] lib: add NO_GENERIC_PCI_IOPORT_MAP
Message-Id: <CACoURw6docF1E4KwvfAAwh3GG0KFo15erj+JJwu0HHB-wtswig@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1327877053.git.mst@redhat.com>
        <d78d91d0166651700cf662a50c87d84da4bdab88.1327877053.git.mst@redhat.com>
In-Reply-To: <d78d91d0166651700cf662a50c87d84da4bdab88.1327877053.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Myron Stowe <myron.stowe@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, James Morris <jmorris@namei.org>, "John W. Linville" <linville@tuxdriver.com>, Michael Witten <mfwitten@gmail.com>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org

Just a minor nit on the comment:

On Mon, Jan 30, 2012 at 6:18 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Some architectures need to override the way
> IO port mapping is does not PCI devices.

Should this line read "IO port mapping is done on PCI devices."?

> Supply a generic function that calls
> ioport_map, and make it possible for architectures
> to override.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Shane
