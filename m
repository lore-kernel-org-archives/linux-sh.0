From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Date: Wed, 22 Apr 2015 12:30:28 +0000
Subject: Re: [PATCH] TESTCASE: of: OOPS when disabling node via OF_DYNAMIC
Message-Id: <83B5C458-8D49-4EF6-9F4A-6C0E2579AB9F@konsulko.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_1ABEC23E-D403-431D-9CB2-848424CD7AB7"
List-Id: <linux-sh.vger.kernel.org>
References: <1427814771-30335-1-git-send-email-wsa@the-dreams.de> <AEA6F5CA-D520-4F34-BE6B-EF2839501089@konsulko.com> <20150414132709.GA1375@katana>
In-Reply-To: <20150414132709.GA1375@katana>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org


--Apple-Mail=_1ABEC23E-D403-431D-9CB2-848424CD7AB7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Wolfram,

> On Apr 14, 2015, at 16:27 , Wolfram Sang <wsa@the-dreams.de> wrote:
>=20
> Hi Pantelis,
>=20
> thanks for your prompt reply. Unfortunately, I had to wait until I =
could
> access the test system again.
>=20

[snip]

Sorry for the non-prompt reply; but just for kicks, can you try the =
attached patch?

I have a hunch this might be the problem.

Regards

=E2=80=94 Pantelis



--Apple-Mail=_1ABEC23E-D403-431D-9CB2-848424CD7AB7
Content-Disposition: attachment;
	filename=0001-pdev-Fix-platform-device-resource-linking.patch
Content-Type: application/octet-stream;
	name="0001-pdev-Fix-platform-device-resource-linking.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20ac2df3acf04afbd9ab7166a4858ce05bb995c4bb=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Pantelis=20Antoniou=20=
<pantelis.antoniou@konsulko.com>=0ADate:=20Fri,=2028=20Dec=202012=20=
11:34:15=20+0200=0ASubject:=20[PATCH]=20pdev:=20Fix=20platform=20device=20=
resource=20linking=0A=0APlatform=20device=20removal=20uncovered=20a=20=
number=20of=20problems=20with=0Athe=20way=20resources=20are=20handled=20=
in=20the=20core=20platform=20code.=0A=0AResources=20now=20form=20=
child/parent=20linkages=20and=20this=20requires=0Aproper=20linking=20of=20=
the=20resources.=20On=20top=20of=20that=20the=20OF=20core=0Adirectly=20=
creates=20it's=20own=20platform=20devices.=20Simplify=20things=0Aby=20=
providing=20helper=20functions=20that=20manage=20the=20linking=20=
properly.=0A=0ATwo=20functions=20are=20provided:=0A=0A=
platform_device_link_resources(),=20which=20links=20all=20the=0Alinkable=20=
resources=20(if=20not=20already=20linked).=0A=0Aand=20=
platform_device_unlink_resources(),=20which=20unlinks=20all=20the=0A=
resources.=0A=0ASigned-off-by:=20Pantelis=20Antoniou=20=
<pantelis.antoniou@konsulko.com>=0A---=0A=20drivers/base/platform.c=20=20=
=20=20=20=20=20=20=20|=20122=20+++++++++++++++++++++++++++-------------=0A=
=20include/linux/platform_device.h=20|=20=20=204=20++=0A=202=20files=20=
changed,=2087=20insertions(+),=2039=20deletions(-)=0A=0Adiff=20--git=20=
a/drivers/base/platform.c=20b/drivers/base/platform.c=0Aindex=20=
ebf034b..08226e2=20100644=0A---=20a/drivers/base/platform.c=0A+++=20=
b/drivers/base/platform.c=0A@@=20-298,6=20+298,80=20@@=20int=20=
platform_device_add_data(struct=20platform_device=20*pdev,=20const=20=
void=20*data,=0A=20}=0A=20EXPORT_SYMBOL_GPL(platform_device_add_data);=0A=
=20=0A+static=20struct=20resource=20*platform_device_parent_resource(=0A=
+=09=09struct=20platform_device=20*pdev,=20struct=20resource=20*r)=0A+{=0A=
+=09unsigned=20long=20type;=0A+=0A+=09if=20(r->parent)=0A+=09=09return=20=
r->parent;=0A+=0A+=09type=20=3D=20resource_type(r);=0A+=09switch=20=
(type)=20{=0A+=09case=20IORESOURCE_MEM:=0A+=09=09return=20=
&iomem_resource;=0A+=09case=20IORESOURCE_IO:=0A+=09=09return=20=
&ioport_resource;=0A+=09/*=20the=20other=20resource=20types=20are=20not=20=
linked,=20so=20no=20action=20*/=0A+=09default:=0A+=09=09break;=0A+=09}=0A=
+=09pr_debug("%s:=20no=20parent=20for=20resource=20%p=20type=200x%lx\n",=0A=
+=09=09=09dev_name(&pdev->dev),=20r,=20resource_type(r));=0A+=09return=20=
NULL;=0A+}=0A+=0A+int=20platform_device_unlink_resources(struct=20=
platform_device=20*pdev)=0A+{=0A+=09struct=20resource=20*r;=0A+=09int=20=
i;=0A+=0A+=09for=20(i=20=3D=20pdev->num_resources=20-=201;=20i=20>=3D=20=
0;=20i--)=20{=0A+=09=09r=20=3D=20&pdev->resource[i];=0A+=09=09if=20=
(r->parent=20=3D=3D=20NULL)=0A+=09=09=09continue;=0A+=09=09=
release_resource(r);=0A+=09}=0A+=09return=200;=0A+}=0A=
+EXPORT_SYMBOL_GPL(platform_device_unlink_resources);=0A+=0A+int=20=
platform_device_link_resources(struct=20platform_device=20*pdev)=0A+{=0A=
+=09int=20i;=0A+=09struct=20resource=20*p,=20*r;=0A+=0A+=09for=20(i=20=3D=20=
0;=20i=20<=20pdev->num_resources;=20i++)=20{=0A+=09=09r=20=3D=20=
&pdev->resource[i];=0A+=0A+=09=09if=20(r->name=20=3D=3D=20NULL)=0A+=09=09=
=09r->name=20=3D=20dev_name(&pdev->dev);=0A+=0A+=09=09/*=20already=20=
linked=20*/=0A+=09=09if=20(r->parent=20!=3D=20NULL)=0A+=09=09=09=
continue;=0A+=0A+=09=09p=20=3D=20platform_device_parent_resource(pdev,=20=
r);=0A+=09=09if=20(p=20&&=20insert_resource(p,=20r))=20{=0A+=09=09=09=
pr_err("%s:=20failed=20to=20claim=20resource=20%d\n",=0A+=09=09=09=20=20=20=
=20=20=20=20dev_name(&pdev->dev),=20i);=0A+=09=09=09goto=20fail;=0A+=09=09=
}=0A+=09}=0A+=0A+=09return=200;=0A+=0A+fail:=0A+=09while=20(--i=20>=3D=20=
0)=20{=0A+=09=09r=20=3D=20&pdev->resource[i];=0A+=09=09if=20(r->parent=20=
=3D=3D=20NULL)=0A+=09=09=09continue;=0A+=09=09release_resource(r);=0A+=09=
}=0A+=09return=20-EBUSY;=0A+}=0A=
+EXPORT_SYMBOL_GPL(platform_device_link_resources);=0A+=0A=20/**=0A=20=20=
*=20platform_device_add=20-=20add=20a=20platform=20device=20to=20device=20=
hierarchy=0A=20=20*=20@pdev:=20platform=20device=20we're=20adding=0A@@=20=
-307,7=20+381,7=20@@=20EXPORT_SYMBOL_GPL(platform_device_add_data);=0A=20=
=20*/=0A=20int=20platform_device_add(struct=20platform_device=20*pdev)=0A=
=20{=0A-=09int=20i,=20ret;=0A+=09int=20ret;=0A=20=0A=20=09if=20(!pdev)=0A=
=20=09=09return=20-EINVAL;=0A@@=20-339,26=20+413,10=20@@=20int=20=
platform_device_add(struct=20platform_device=20*pdev)=0A=20=09=09break;=0A=
=20=09}=0A=20=0A-=09for=20(i=20=3D=200;=20i=20<=20pdev->num_resources;=20=
i++)=20{=0A-=09=09struct=20resource=20*p,=20*r=20=3D=20=
&pdev->resource[i];=0A-=0A-=09=09if=20(r->name=20=3D=3D=20NULL)=0A-=09=09=
=09r->name=20=3D=20dev_name(&pdev->dev);=0A-=0A-=09=09p=20=3D=20=
r->parent;=0A-=09=09if=20(!p)=20{=0A-=09=09=09if=20(resource_type(r)=20=
=3D=3D=20IORESOURCE_MEM)=0A-=09=09=09=09p=20=3D=20&iomem_resource;=0A-=09=
=09=09else=20if=20(resource_type(r)=20=3D=3D=20IORESOURCE_IO)=0A-=09=09=09=
=09p=20=3D=20&ioport_resource;=0A-=09=09}=0A-=0A-=09=09if=20(p=20&&=20=
insert_resource(p,=20r))=20{=0A-=09=09=09dev_err(&pdev->dev,=20"failed=20=
to=20claim=20resource=20%d\n",=20i);=0A-=09=09=09ret=20=3D=20-EBUSY;=0A-=09=
=09=09goto=20failed;=0A-=09=09}=0A-=09}=0A+=09/*=20make=20sure=20the=20=
resources=20are=20linked=20properly=20*/=0A+=09ret=20=3D=20=
platform_device_link_resources(pdev);=0A+=09if=20(ret=20!=3D=200)=0A+=09=09=
goto=20failed_res;=0A=20=0A=20=09pr_debug("Registering=20platform=20=
device=20'%s'.=20Parent=20at=20%s\n",=0A=20=09=09=20=
dev_name(&pdev->dev),=20dev_name(pdev->dev.parent));=0A@@=20-367,20=20=
+425,14=20@@=20int=20platform_device_add(struct=20platform_device=20=
*pdev)=0A=20=09if=20(ret=20=3D=3D=200)=0A=20=09=09return=20ret;=0A=20=0A=
-=20failed:=0A+=09platform_device_unlink_resources(pdev);=0A+=0A+=20=
failed_res:=0A=20=09if=20(pdev->id_auto)=20{=0A=20=09=09=
ida_simple_remove(&platform_devid_ida,=20pdev->id);=0A=20=09=09pdev->id=20=
=3D=20PLATFORM_DEVID_AUTO;=0A=20=09}=0A=20=0A-=09while=20(--i=20>=3D=20=
0)=20{=0A-=09=09struct=20resource=20*r=20=3D=20&pdev->resource[i];=0A-=09=
=09unsigned=20long=20type=20=3D=20resource_type(r);=0A-=0A-=09=09if=20=
(type=20=3D=3D=20IORESOURCE_MEM=20||=20type=20=3D=3D=20IORESOURCE_IO)=0A=
-=09=09=09release_resource(r);=0A-=09}=0A-=0A=20=20err_out:=0A=20=09=
return=20ret;=0A=20}=0A@@=20-396,8=20+448,6=20@@=20=
EXPORT_SYMBOL_GPL(platform_device_add);=0A=20=20*/=0A=20void=20=
platform_device_del(struct=20platform_device=20*pdev)=0A=20{=0A-=09int=20=
i;=0A-=0A=20=09if=20(pdev)=20{=0A=20=09=09device_del(&pdev->dev);=0A=20=0A=
@@=20-406,13=20+456,7=20@@=20void=20platform_device_del(struct=20=
platform_device=20*pdev)=0A=20=09=09=09pdev->id=20=3D=20=
PLATFORM_DEVID_AUTO;=0A=20=09=09}=0A=20=0A-=09=09for=20(i=20=3D=200;=20i=20=
<=20pdev->num_resources;=20i++)=20{=0A-=09=09=09struct=20resource=20*r=20=
=3D=20&pdev->resource[i];=0A-=09=09=09unsigned=20long=20type=20=3D=20=
resource_type(r);=0A-=0A-=09=09=09if=20(type=20=3D=3D=20IORESOURCE_MEM=20=
||=20type=20=3D=3D=20IORESOURCE_IO)=0A-=09=09=09=09release_resource(r);=0A=
-=09=09}=0A+=09=09platform_device_unlink_resources(pdev);=0A=20=09}=0A=20=
}=0A=20EXPORT_SYMBOL_GPL(platform_device_del);=0Adiff=20--git=20=
a/include/linux/platform_device.h=20b/include/linux/platform_device.h=0A=
index=2058f1e75..eabfd9c=20100644=0A---=20=
a/include/linux/platform_device.h=0A+++=20=
b/include/linux/platform_device.h=0A@@=20-331,4=20+331,8=20@@=20extern=20=
int=20platform_pm_restore(struct=20device=20*dev);=0A=20#define=20=
USE_PLATFORM_PM_SLEEP_OPS=0A=20#endif=0A=20=0A+/*=20helper=20functions=20=
for=20resource=20list=20management=20*/=0A+int=20=
platform_device_unlink_resources(struct=20platform_device=20*pdev);=0A=
+int=20platform_device_link_resources(struct=20platform_device=20*pdev);=0A=
+=0A=20#endif=20/*=20_PLATFORM_DEVICE_H_=20*/=0A--=20=0A1.7.12=0A=0A=

--Apple-Mail=_1ABEC23E-D403-431D-9CB2-848424CD7AB7--
