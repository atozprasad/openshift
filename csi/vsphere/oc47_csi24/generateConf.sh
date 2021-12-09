#!/bin/bash
source vsphere.env
rm -f csi-vsphere.conf temp.conf
( echo "cat <<EOF >csi-vsphere.conf";
  cat csi-vsphere.conf.template;
  echo "EOF";
) >temp.yaml
. temp.yaml

rm -f vsphere.conf temp.conf
( echo "cat <<EOF >vsphere.conf";
  cat vsphere.conf.template;
  echo "EOF";
) >temp.yaml
. temp.yaml

rm temp.yaml
